package com.identityblitz.idp.flow.dynamic;

import java.lang.*;
import java.util.*;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import com.identityblitz.idp.login.authn.flow.Context;
import com.identityblitz.idp.login.authn.flow.Strategy;
import com.identityblitz.idp.login.authn.flow.StrategyState;
import com.identityblitz.idp.login.authn.flow.StrategyBeginState;
import com.identityblitz.idp.flow.dynamic.*;

import static com.identityblitz.idp.login.authn.flow.StrategyState.*;

public class FFmethods implements Strategy {
    private final Logger logger = LoggerFactory.getLogger("com.identityblitz.idp.flow.dynamic");


    @Override public StrategyBeginState begin(final Context ctx) {
        if(ctx.claims("subjectId") != null)
            return StrategyState.ENOUGH();
        else
            return StrategyState.MORE(new String[]{"password","x509"});

        /**
         * This procedure by default enables only username/password methods and digital signatures as the first factor. You can change the available methods by editing the list ("password","x509") by adding or deleting methods. You can use the following method names:
         *     password - username and password
         *     x509 - digital signature
         *     externalIdps - social networks
         *     spnego - domain authentication
         * E.g. if you want the user to log in using username/password and social networks, then change the line with StrategyState.MORE in the following way:
         *
         *     return StrategyState.MORE(new String[]{"password","externalIdps"});
         *
         * After the change you should assign this procedure to the application. If the listed methods are not configured, they are not displayed.
         *
         */

    }

    @Override public StrategyState next(final Context ctx) {
        Integer reqFactor = (ctx.user() == null) ? null : ctx.user().requiredFactor();
        if(reqFactor == null || reqFactor == 0)
            return StrategyState.ENOUGH();
        else {
            if(reqFactor == ctx.justCompletedFactor())
                return StrategyState.ENOUGH();
            else
                return StrategyState.MORE(new String[]{});
        }
    }
}