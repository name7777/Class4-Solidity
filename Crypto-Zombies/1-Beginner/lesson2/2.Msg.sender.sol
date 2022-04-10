/* Msg.sender
 * 솔리디티에는 모든 함수에서 이용 가능한 특정 전역 변수들이 있지. 그 중의 하나가 현재 함수를 호출한 사람 (혹은 스마트 컨트랙트)의 주소를 가리키는 msg.sender이지.
 * 참고
    솔리디티에서 함수 실행은 항상 외부 호출자가 시작하네.
    컨트랙트는 누군가가 컨트랙트의 함수를 호출할 때까지 블록체인 상에서 아무 것도 안 하고 있을 것이네.
    그러니 항상 msg.sender가 있어야 하네.
 * msg.sender를 이용하고 mapping을 업데이트하는 예시가 여기에 있네:
    https://cryptozombies.io/ko/lesson/2/chapter/3

 * 문제
    1) 먼저, 새로운 좀비의 id가 반환된 후에 zombieToOwner 매핑을 업데이트하여 id에 대하여 msg.sender가 저장되도록 해보자.
    2) 그 다음, 저장된 msg.sender을 고려하여 ownerZombieCount를 증가시키자.
    참고)
    자바스크립트와 마찬가지로 솔리디티에서도 uint를 ++로 증가시킬 수 있다.
    uint number = 0;
    number++;
    // `number`는 이제 `1`이다
    자네의 최종 답안은 코드 2줄로 표현되어야 하네.
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

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // 여기서 시작
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
