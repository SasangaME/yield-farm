//SPDX-License-Identifier: MIT

pragma solidity =0.8.4;

contract DappToken {
    string public name = "DApp Token";
    string public symbol = "DAP";
    uint256 public totalSupply = 1 * 10**24;
    uint256 public decimals = 18;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _to, uint256 _value);

    mapping(address => uint256) public balanceOf;

    mapping(address => mapping(address => uint256)) public allowances;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        require(balanceOf[_from] >= _value);
        require(allowances[_from][msg.sender] >= _value);
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowances[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
