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
import com.identityblitz.idp.login.authn.flow.More;


import static com.identityblitz.idp.login.authn.flow.StrategyState.*;

public class Require2ndFactor implements Strategy {
    private final Logger logger = LoggerFactory.getLogger("com.identityblitz.idp.flow.dynamic");


    @Override public StrategyBeginState begin(final Context ctx) {
        if(ctx.claims("subjectId") != null){

// if the user is already authenticated, then we check the number of factors passed

            if (ctx.sessionTrack().split(",").length < 2)
                return StrategyState.MORE(new String[]{});
            else
                return StrategyState.ENOUGH();
        }

// if he is not authenticated or passed less than 2 factors, then we require passing the next level of authentication

        else {
            return StrategyState.MORE(new String[]{});
        }
    }

    @Override public StrategyState next(final Context ctx) {

// if the user has passed one authentication factor, then we require a second one; if more than one - we sign in to the application

        if(ctx.justCompletedFactor() == 1)
            return StrategyState.MORE(new String[]{});
        else
            return StrategyState.ENOUGH();
    }
}