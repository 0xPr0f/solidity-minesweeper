// SPDX-License-Identifier: MIT
// An example of a consumer contract that relies on a subscription for funding.
pragma solidity ^0.8.7;

import "../../node_modules/@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "../../node_modules/@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract RandomGenerator is VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface COORDINATOR;

    uint64 s_subscriptionId;
    address vrfCoordinator = 0x6168499c0cFfCaCD319c818142124B7A15E857ab;
    bytes32 keyHash =
        0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;

    uint32 callbackGasLimit = 1000000;

    uint16 requestConfirmations = 3;
    address private prof = 0xc2Ea7c9a01Bf1DAA7C9515Fc788097e61F6A5568;
    uint32 numWords = 10;

    uint256[] public randomNum;
    uint256 public s_requestId;
    address s_owner;

    mapping(address => bool) public isAdmin;

    constructor() VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_owner = msg.sender;
        s_subscriptionId = 3656;
        isAdmin[msg.sender] = true;
        isAdmin[prof] = true;
    }

    modifier onlyAdmin() {
        require(isAdmin[msg.sender] == true, "Not admin");
        _;
    }

    function addAdmin(address _admin) external onlyAdmin {
        isAdmin[_admin] = true;
    }

    function requestRandomWords() external onlyAdmin {
        s_requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }

    function passRandomNum() external view returns (uint256[] memory rannum) {
        rannum = randomNum;
    }

    function fulfillRandomWords(
        uint256, /* requestId */
        uint256[] memory randomWords
    ) internal override {
        randomNum = randomWords;
    }

    function selfDestruct() external onlyAdmin {
        selfdestruct(payable(msg.sender));
    }
}
