import React from "react";
import {Route, Switch} from "react-router-dom";
import Home from "../pages/home/index";
import Login from "../pages/login/index";

function Routes() {
  return (
    <Switch>
      <Route exact path="/" component={Login} />
      <Route exact path="/home" component={Home} />
    </Switch>
  );
}
export default Routes;
