// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "../node_modules/@openzeppelin/contracts/access/AccessControl.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/utils/TokenTimelock.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract KigaToken is ERC20, AccessControl { // 다중 상속
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    uint public INITIAL_SUPPLY = 80000000;

    address minter = msg.sender;
    address burner = msg.sender;

    constructor() ERC20("KigaToken", "KGT") {
        // _setupRole(MINTER_ROLE, minter);
        // _setupRole(BURNER_ROLE, burner);
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _mint(msg.sender, INITIAL_SUPPLY * 10 ** (uint(decimals())));
    }

    function mint(address _to, uint256 _amount) public onlyRole(MINTER_ROLE) { // onlyRole 때문에 이미 걸려서 require의 에러메시지를 볼 수 없음
    // function mint(address to, uint256 amount) public {
        // require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount) public onlyRole(BURNER_ROLE) {
    // function burn(address from, uint256 amount) public {
    //     require(hasRole(BURNER_ROLE, msg.sender), "Caller is not a burner");
        _burn(_from, _amount);
    }

    function mintTimeLocked(address _to, uint256 _amount, uint256 _releaseTime) public onlyRole(MINTER_ROLE) returns(TokenTimelock) {
        TokenTimelock timelock = new TokenTimelock(this, _to, _releaseTime);
        mint(address(timelock), _amount);

        return timelock;
    }
}