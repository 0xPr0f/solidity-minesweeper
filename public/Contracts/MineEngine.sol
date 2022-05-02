//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./RandomGenerator.sol";

/// @title MineEngine - the first 100% on-chain Mine Sweeper engine.
/// @author 0xpr0f
// deployed at : 0xCfa74A35AB1efC5569b585FDC8bFB93b9743390d
contract MineEngine {

    event movedTile       (address indexed player, uint256 id);
    event failed          (address indexed player, bool inGame);
    event passed          (address indexed player, uint256 id);
    event generatedTiles  (address indexed oracle, address indexed player, uint256 length );

    error HitAMine(string message, uint256 mineId);

//////////       Base Variables       ////////////////////
    address public generator;
    uint256[] internal mineTiles;
    mapping(address => bool) public isAdmin;
    mapping(address => mapping(uint256 => uint256)) internal moved;

    string public constant NAME = "0xProf's MineSweeper";
    string public constant DIFFICULTY = "Normal";

///////////////////////////////////////////////////////////////


/// @notice Assign Random Generator to Deployed Oracle 
    constructor(address profOracleGenerator) {
        generator = profOracleGenerator;
        isAdmin[msg.sender] = true;
    }

    fallback() external payable {}

    receive() external payable {}


///  Request RandomNess from oracle ///
/// @notice Request Randomness from oracle contract connected to a vrf stream ///
    function GetRandomNum() external {
        for (uint256 i = 0; i <= 10; ++i) {
            moved[msg.sender][i] = 0;
        }
        RandomGenerator(generator).requestRandomWords();
        mineTiles = RandomGenerator(generator).passRandomNum();
        emit generatedTiles(generator, msg.sender, mineTiles.length);
    }

///  Cap Mine Tiles///
/// @dev Reduces the vrf numbers into sizable Mine Tiles ///
    function capMinesTiles() external {
        uint256 length = mineTiles.length;
        for (uint256 i = 0; i < length; ++i) {
            mineTiles[i] = mineTiles[i] % 36;
        }
    }

    modifier onlyAdmin() {
        require(isAdmin[msg.sender] == true, "Not admin");
        _;
    }

///  Return Cap Mines  ///
/// @dev This Returns the available mine spots in the game ///
    function getCappedMinesTiles()
        external
        view
        onlyAdmin
        returns (uint256[] memory)
    {
        return mineTiles;
    }


///  Check Tiles ///
/// @dev This performs a state change to emnit event check on the tile ///
/// @param _id of Mine ////
    function move(uint256 _id) external returns (bool b) {
        uint256 length = mineTiles.length;
        require(moved[msg.sender][_id] == 0, "You have moved here");
        require(moved[msg.sender][_id] != 2, "Game Over");
        moved[msg.sender][_id] = 1;
        for (uint256 i = 0; i < length; ++i) {
            if (mineTiles[i] == _id) {
                b = true;
                moved[msg.sender][_id] = 2;
                emit failed(msg.sender, false);
                revert HitAMine("Hit Mine Id : ", _id);
            }
        }
        emit movedTile(msg.sender, _id);
    }

///  Gaslessly Check Tiles ///
/// @dev This is gasless and performs a non state changing check on the tile ///
/// @param _id of Mine ////
    function gaslessMoveCheckAvailability(uint256 _id)
        external
        view
        returns (bool b)
    {
        require(moved[msg.sender][_id] == 0, "You have moved here");
        require(moved[msg.sender][_id] != 2, "Game Over");
        uint256 length = mineTiles.length;
        for (uint256 i = 0; i < length; ++i) {
            if (mineTiles[i] == _id) {
                b = true;
            }
        }
    }
}
