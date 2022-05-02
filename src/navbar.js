import React from "react";
import { Link } from "react-router-dom";
import "./styles/App.css";

const Navbar = () => {
  return (
    <div>
      {" "}
      <div
        id="navbar"
        style={{ display: "flex", justifyContent: "space-evenly" }}
      >
        <li>
          <Link to="/">Mine Sweeper</Link>
        </li>
        <li>
          <Link to="/howto">How To Sweep</Link>
        </li>
        <li>
          <Link to="/about">About</Link>
        </li>
      </div>
    </div>
  );
};

export default Navbar;
