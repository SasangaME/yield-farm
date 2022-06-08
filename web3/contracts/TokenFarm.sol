//SPDX-License-Identifier: MIT

pragma solidity =0.8.4;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    string public name = "DApp Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;
    address[] public stakers;
    mapping(address => uint256) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "caller must be the owner");
        _;
    }

    constructor(DappToken _dappToken, DaiToken _daiToken) {
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    function stakeTokens(uint256 _amount) public {
        require(_amount > 0, "cannot stake 0 tokens");
        daiToken.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] += _amount;

        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    function issueToken() public onlyOwner {
        for (uint256 i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint256 balance = stakingBalance[recipient];
            if (balance > 0) {
                dappToken.transfer(recipient, balance);
            }
        }
    }

    function unstake() {
        // withdraw all the funds
    }
}
