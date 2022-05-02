import React from "react";
import Navbar from "./navbar";

export const About = () => {
  return (
    <div>
      <Navbar />
      <h2>About</h2>
      <div style={{ width: "555px" }}>
        <ul>
          <li>
            This is a typical Mine Sweeper game, but built on the ethereum
            blockchain with chainlink oracle
          </li>
          <br />
          <li>
            Created by
            <a
              rel="noreferrer"
              target="_blank"
              href="https://github.com/0xpr0f"
            >
              &nbsp;0xpr0f
            </a>
          </li>

          <br />
          <li>There are currently some Known bugs</li>
          <li>
            <u>Example:</u>{" "}
          </li>
          <li>
            {" "}
            1) There can be a collision of random numbers making it less on the
            mine map.{" "}
          </li>
          <li>
            2) The oracle process time maybe slow causing it to delay or
            potentially return nothing.
          </li>
          <li>3) Possibly a UI error.</li>
          <br />
          <li>
            Any bugs found or improvement suggested, you can contact me by
            creating an issue on the project{" "}
            <a
              rel="noreferrer"
              target="_blank"
              href="https://github.com/0xPr0f/SolidityMineSweeper/issues"
            >
              &nbsp;github{" "}
            </a>
          </li>
        </ul>
      </div>
    </div>
  );
};
