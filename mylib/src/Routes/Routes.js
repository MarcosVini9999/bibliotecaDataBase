import React from "react";
import {Route} from "react-router-dom";
import Home from "../pages/home/index";
import Login from "../pages/login/index";

function Routes() {
  return (
    <Routes>
      <Route path="/" element={<Login />} />
      <Route path="/home" element={<Home />} />
    </Routes>
  );
}
export default Routes;
