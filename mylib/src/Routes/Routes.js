import React from "react";
import {Route, Switch} from "react-router-dom";
import Home from "../pages/home/index";
import HomeLIB from "../pages/homeLIB";
import HomeADM from "../pages/homeADM";
import Login from "../pages/login/index";

function Routes() {
  return (
    <Switch>
      <Route exact path="/" component={Login} />
      <Route exact path="/home" component={Home} />
      <Route exact path="/homeADM" component={HomeADM} />
      <Route exact path="/homeLIB" component={HomeLIB} />
    </Switch>
  );
}
export default Routes;
