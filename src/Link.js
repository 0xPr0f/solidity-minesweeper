import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import { Routes, Route } from "react-router-dom";
import { About } from "./about";
import { HowTo } from "./HowTo";
import App from "./App";

function Link() {
  return (
    <div>
      <div className="App">
        <Router>
          <Routes>
            <Route path="/" exact element={<App />} />
            <Route path="/" element={<App />} />
            <Route path="/about" element={<About />} />
            <Route path="/howto" element={<HowTo />} />
          </Routes>
        </Router>
      </div>
    </div>
  );
}
export default Link;
