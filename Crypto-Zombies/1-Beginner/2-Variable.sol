/* 상태 변수 & 정수
 * '상태 변수'는 컨트랙트 저장소에 영구적으로 저장된다
 * 즉, 이더리움 블록체인에 기록된다 (=데이터베이스에 데이터를 쓰는 것과 동일)

 * uint : 부호없는 정수. 값은 무조건 양수. 실제로 uint256으로 기본 256비트를 지원 (int는 부호를 허용)
 
 */

pragma solidity ^0.4.19;

contract ZombieFactory {
    uint dnaDigits = 16;
}