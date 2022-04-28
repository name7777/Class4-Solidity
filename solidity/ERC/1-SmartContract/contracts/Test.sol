// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Test {
    string public constant name = "TEST Token";
    string public constant symbol = "TEST";
    uint public constant decimals = 18;
    // 초기 발행량 : 10000.000000000000000000
    uint public constant INITIAL_SUPPLY = 10000 * 10 ** decimals;
    string constant teststring = "You can't see this string";
}