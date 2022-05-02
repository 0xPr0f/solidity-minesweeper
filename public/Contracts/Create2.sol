// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;
//@notice Salted contract creations / create2
import "./MineEngine.sol";

contract Create2A {
    mapping(address => bool) public isAdmin;

    modifier onlyAdmin() {
        require(isAdmin[msg.sender] == true, "Not admin");
        _;
    }

    constructor() {
        isAdmin[msg.sender] = true;
    }

    function getBytes32(uint256 salt)
        external
        view
        onlyAdmin
        returns (bytes32)
    {
        return bytes32(salt);
    }

    function getAddress(bytes32 salt)
        external
        view
        onlyAdmin
        returns (address)
    {
        address addr = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xff),
                            address(this),
                            salt,
                            keccak256(
                                abi.encodePacked(type(MineEngine).creationCode)
                            )
                        )
                    )
                )
            )
        );

        return addr;
    }

    address public deployedAddr;

    function createDSalted(bytes32 salt) public onlyAdmin {
        MineEngine engine = new MineEngine{salt: salt}();
        deployedAddr = address(engine);
    }
}
