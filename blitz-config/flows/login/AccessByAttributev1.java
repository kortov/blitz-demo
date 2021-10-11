package com.identityblitz.idp.flow.dynamic;

import java.lang.*;
import java.util.*;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import com.identityblitz.idp.login.authn.flow.Context;
import com.identityblitz.idp.login.authn.flow.Strategy;
import com.identityblitz.idp.login.authn.flow.StrategyState;
import com.identityblitz.idp.flow.dynamic.*;

import static com.identityblitz.idp.login.authn.flow.StrategyState.*;

public class AccessByAttribute implements Strategy {

    private final Logger logger = LoggerFactory.getLogger("com.identityblitz.idp.flow.dynamic");


    @Override public StrategyState begin(final Context ctx) {
        if(ctx.claims("subjectId") != null){

// if the user is already authenticated, then check his attribute access

            int appListIdx = 0;
            boolean hasAccess = false;
            while (appListIdx > -1) {
                String app = ctx.claims("appList.[" + appListIdx + "]");
                logger.debug("app [" + appListIdx + "] = " + app);
                if (app == null){ appListIdx = -1; }
                else if (app.equals(ctx.appId())) { appListIdx = -1; hasAccess = true; }
                else { appListIdx ++; logger.debug("AppList index = " + appListIdx); }
            }

            if(hasAccess)
                return StrategyState.ENOUGH();
            else
                return StrategyState.DENY;
        }

// if user has not been authenticated, then we ask him to pass the first factor of authentication

        else
            return StrategyState.MORE(new String[]{});
    }


    @Override public StrategyState next(final Context ctx) {

// after primary authentication, we check his attribute appList, if it is correct, then we analyze the requiredFactor parameter of the user (the required level of authentication) and depending on this require the second factor

        int appListIdx = 0;
        boolean hasAccess = false;
        while (appListIdx > -1) {
            String app = ctx.claims("appList.[" + appListIdx + "]");
            logger.debug("app [" + appListIdx + "] = " + app);
            if (app == null){ appListIdx = -1; }
            else if (app.equals(ctx.appId())) { appListIdx = -1; hasAccess = true; }
            else { appListIdx ++; logger.debug("AppList index = " + appListIdx); }
        }

        if(!hasAccess)
            return StrategyState.DENY;
        String reqFactor = ctx.userProps("requiredFactor");
        if(reqFactor == null)
            return StrategyState.ENOUGH();
        else {
            if(Integer.valueOf(reqFactor) == ctx.justCompletedFactor())
                return StrategyState.ENOUGH();
            else
                return StrategyState.MORE(new String[]{});
        }
    }
}