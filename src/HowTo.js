import React from "react";
import Navbar from "./navbar";

export const HowTo = () => {
  return (
    <div>
      <Navbar />
      <h2>How To Sweep</h2>
      <div style={{ width: "555px" }}>
        <ul>
          <li>------ This is currently on the rinkeby network -------</li>
          <li>
            1) Click the start game button it it will connect your current game
            to an oracle and enable you to play.
          </li>
          <li>
            2) When selecting tiles, accept all trasactions, the contract has
            been made to reduce signifant amount of gas for onChain activities.
          </li>
          <li> 3) All activities are done onChain and with an oracle.</li>
          <li>
            4) There are 10 bombs on the mine map, try your best to predict them
            and avoid them, else you lose the prize.
          </li>
          <li>
            5) When you step on a bomb, you can restart the game, and you will
            have to reconnect to the oracle again.
          </li>
          <li>6) Do not reload the page expect you aim to start again</li>
        </ul>
      </div>
    </div>
  );
};
