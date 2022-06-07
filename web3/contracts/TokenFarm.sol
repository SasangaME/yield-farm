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

    constructor(DappToken _dappToken, DaiToken _daiToken) {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }

    function stakeTokens(uint256 _amount) public {
        daiToken.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] += _amount;

        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        hasStaked[msg.sender] = true;
    }
}
