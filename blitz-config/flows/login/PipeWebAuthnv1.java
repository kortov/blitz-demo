package com.identityblitz.idp.flow.dynamic;

import java.lang.*;
import java.util.*;
import java.text.*;
import java.time.*;
import java.math.*;
import java.security.*;
import javax.crypto.*;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import com.identityblitz.idp.login.authn.flow.Context;
import com.identityblitz.idp.login.authn.flow.Strategy;
import com.identityblitz.idp.login.authn.flow.StrategyState;
import com.identityblitz.idp.login.authn.flow.StrategyBeginState;
import com.identityblitz.idp.login.authn.flow.ctx.wak.WakMeta;
import com.identityblitz.idp.login.authn.flow.ctx.wak.*;
import com.identityblitz.idp.flow.common.model.*;
import com.identityblitz.idp.login.authn.flow.LCookie;
import com.identityblitz.idp.login.authn.flow.api.*;
import com.identityblitz.idp.flow.common.api.*;
import com.identityblitz.idp.flow.dynamic.*;
import java.lang.invoke.LambdaMetafactory;
import java.util.function.Consumer;
import com.identityblitz.idp.login.authn.flow.StrategyState.*;
import com.identityblitz.idp.login.authn.flow.LBrowser;


public class PipeWebAuthn implements Strategy {

    private final Logger logger = LoggerFactory.getLogger("com.identityblitz.idp.flow.dynamic");
  	private final static String DOMAIN = "example.com";
	private final static Integer SKIP_TIME_IN_SEC = 60;
    private final static Boolean ASK_AT_1ST_LOGIN = true;
  
    @Override public StrategyBeginState begin(final Context ctx) {
        if ("login".equals(ctx.prompt())){
            List<String> methods = new ArrayList<String>(Arrays.asList(ctx.availableMethods()));
            methods.remove("cls");
            return StrategyState.MORE(methods.toArray(new String[0]), true);
        } else {
            if(ctx.claims("subjectId") != null)
                return StrategyState.ENOUGH();
            else
                return StrategyState.MORE(new String[]{});
        }
    }

  	@Override
	public StrategyState next(Context ctx) {
        Boolean new_device = false;

      	if (ctx.ua().getNewlyCreated() && ctx.justCompletedFactor() == 1 && !ASK_AT_1ST_LOGIN){
         	logger.debug("User with sub={} is signing in, pid={}, on a new device", ctx.claims("subjectId"), ctx.id());
          	new_device = true;
        }      
		if (ctx.user() == null || ctx.user().requiredFactor() == null
				|| ctx.user().requiredFactor().equals(ctx.justCompletedFactor()))
          	if (!new_device && requiredWebAuthn(ctx)) return webAuthn(ctx);
            else return StrategyState.ENOUGH();
		else
			return StrategyState.MORE(new String[] {});
	}

    private boolean requiredWebAuthn(final Context ctx) {
      	LBrowser br = ctx.ua().asBrowser();
      	String deviceType = br.getDeviceType();
      	String os = br.getOsName();
        List<WakMeta> keyList = null;
        logger.trace("User subjectId = {}, pid = {} is logging using device '{}' and OS '{}', checking configured webAuthn keys", ctx.claims("subjectId"), ctx.id(), deviceType, os);
        ListResult<WakMeta> keys = ctx.dataSources()
          .webAuthn()
          .keysOfCurrentSubject();
      	if (keys != null) {
      		keyList = keys.filter(k -> deviceType.equals(k.addedOnUA().deviceType()))
              .filter(k -> os.equals(k.addedOnUA().osName()))
              .list();
        }
      	if (keys != null && keyList.size() > 0) {
            logger.debug("User subjectId = {}, pid = {} has '{}' webAuthn keys for device '{}' and OS '{}'", ctx.claims("subjectId"), ctx.id(), keyList.size(), deviceType, os);  
          	return false;
        } else {
            logger.debug("User subjectId = {}, pid = {} has no configured webAuthn keys for device '{}' and OS '{}'", ctx.claims("subjectId"), ctx.id(), deviceType, os);  
        }
      	Long disagreedOn = ctx.user().userProps().numProp("pipes.addKey." + deviceType + "." + os + ".disagreedOn");
          if (disagreedOn == null) {
            return true;
          } else if (Instant.now().getEpochSecond() - disagreedOn > SKIP_TIME_IN_SEC) {
            logger.debug("User subjectId = {}, pid = {} has skipped Webauthn '{}' seconds ago, so open webAuthn pipe", ctx.claims("subjectId"), ctx.id(), (Instant.now().getEpochSecond() - disagreedOn));
            return true;
          } else {
            logger.debug("User subjectId = {}, pid = {} has skipped Webauthn '{}' seconds ago, no need to open webAuthn pipe", ctx.claims("subjectId"), ctx.id(), (Instant.now().getEpochSecond() - disagreedOn));
            return false;
          }
    }

    private StrategyState webAuthn(final Context ctx) {
        String uri = "https://"+DOMAIN+"/blitz/pipes/conf/webAuthn/start?&canSkip=true&appId=_blitz_profile";
        Set<String> claims = new HashSet<String>(){{
        	add("instanceId");
        }};
        Set<String> scopes = new HashSet<String>(){{
            add("openid");
        }};
       Map<String, Object> urParams = new HashMap<String, Object>();
       return StrategyState.ENOUGH_BUILDER()
         .withPipe(uri, "_blitz_profile", scopes, claims)
         .build();
    }
}