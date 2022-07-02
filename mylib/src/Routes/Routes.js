import React from "react";
import {Switch, Route} from "react-router-dom";
import Login from "../pages/login";
import Home from "../pages/home";

function Routes() {
  return (
    <Switch>
      <Route exact path="/">
        <Login />
      </Route>

      <Route exact path="/home">
        <Home />
      </Route>
    </Switch>
  );
}
export default Routes;
