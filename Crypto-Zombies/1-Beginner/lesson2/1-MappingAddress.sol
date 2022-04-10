/* 매핑과 주소
 * 주소
    이더리움 블록체인은 은행 계좌와 같은 계정들로 이루어져 있지. 계정은 이더리움 블록체인상의 통화인 "이더"의 잔액을 가지지. 
    자네의 은행 계좌에서 다른 계좌로 돈을 송금할 수 있듯이, 계정을 통해 다른 계정과 이더를 주고 받을 수 있지.
    각 계정은 은행 계좌 번호와 같은 주소를 가지고 있네. 주소는 특정 계정을 가리키는 고유 식별자로, 다음과 같이 표현되지: 0x0cE446255506E92DF41614C46F1d6df9Cc969183
    이후 레슨에서 주소에 관한 핵심 내용을 알아 볼 것일세. 지금은 자네가 "주소는 특정 유저(혹은 스마트 컨트랙트)가 소유한다"라는 점만 이해하면 되네.
    그러니까 주소를 우리 좀비들에 대한 소유권을 나타내는 고유 ID로 활용할 수 있네. 
    유저가 우리 앱을 통해 새로운 좀비를 생성하면 좀비를 생성하는 함수를 호출한 이더리움 주소에 그 좀비에 대한 소유권을 부여하지.

 * 매핑
    레슨 1에서 구조체와 배열을 살펴 봤네. 매핑은 솔리디티에서 구조화된 데이터를 저장하는 또다른 방법이지.
    다음과 같이 매핑을 정의하지:
    - ex1) 금융 앱용으로, 유저의 계좌 잔액을 보유하는 uint를 저장한다: 
        mapping (address => uint) public accountBalance;
    - ex2) 혹은 userID로 유저 이름을 저장/검색하는 데 매핑을 쓸 수도 있다 
        mapping (uint => string) userIdToName
    매핑은 기본적으로 키-값 (key-value) 저장소로, 데이터를 저장하고 검색하는 데 이용된다.
    ex1)에서 키는 address이고 값은 uint이다. ex2)에서 키는 uint이고 값은 string이다.

 * 문제
    1) zombieToOwner라는 매핑을 생성한다. 키는 uint이고 (좀비 ID로 좀비를 저장하고 검색할 것이다), 값은 address이다. 이 매핑을 public으로 설정하자.
    2) ownerZombieCount라는 매핑을 생성한다. 키는 address이고 값은 uint이다.
 */

pragma solidity ^0.4.19;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // 여기서 매핑 선언
    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        NewZombie(id, _name, _dna);
    } 

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
