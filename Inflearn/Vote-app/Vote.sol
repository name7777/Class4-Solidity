/* 작업 flow
 * 1) candidator(후보자 등록)
 * 2) get candidator(후보자 호출)
 * 3) voting(투표)
 * 4) finish vote(투표 종료)
*/

// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7;

contract Vote {

    // structure => 후보자 등록 시 어떤 후보인지, 몇 표를 받았는지 등 필요한 정보를 구조화 하기 위함
    struct candidator {
        string name;
        uint upVote;
    }

    // variable
    bool live;
    address owner; // 이 contract를 만든이 (finish vote에서 활용하기 위함)
    candidator[] public candidatorList; // 여기서 후보자들을 배열에 담고 get candidator 가능

    // mapping
    mapping(address => bool) Voted; // 한 계정 당 중복 투표를 막기 위해 bool로 판단

    // event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote); // 누가? 몇 표를?
    event FinishVote(bool live);
    event Voting(address owner);

    // modifier => 아무나 finish vote를 하면 안되므로 필요
    modifier onlyOwner {
        require(msg.sender == owner);
        _; // 위 require가 맞다면 로직은 계속 진행하라는 의미
    }

    // constructor
    constructor() public { // contract가 처음 생성됐을 때 owner를 설정
        owner = msg.sender;
        live = true;

        emit Voting(owner);
    }

    // 1) candidator
    function addCandidator(string memory _name) public onlyOwner{ // 외부에서 호출해야하기 때문에 public. 여기서 아무나 후보자를 등록하지 않고 owner만 등록하도록 설정
        require(live == true); // 투표가 종료됐는지 안됐는지 판단
        require(candidatorList.length < 5); // ★ require: 조건, 즉 후보자들은 5명이 넘게 되면 로직이 더 이상이 진행되지 않는다 (즉, 후보자를 무제한 생성하는 것을 막음으로서 가스를 절약)
        candidatorList.push(candidator(_name, 0));

        // emit event: 후보자가 추가됐다고 알려주기 위한 event
        emit AddCandidator(_name);
    }

    // 2) get candidator => candidator라는 변수를 public으로 선언하면 getter함수가 만들어지기 때문에 만들 필요는 없을 것 같음 (변수를 읽어올 수 있기 때문) => 위 variable 참고

    // 3) voting
    function upVote(uint _indexOfCandidator) public {
        require(live == true);
        require(_indexOfCandidator < candidatorList.length); // 조건: 후보자는 5명 미만이니 upVote(받은 투표수) 역시 그 이하여야 정상
        require(Voted[msg.sender] == false); // 투표하는 계정이 중복으로 투표는 하지 않는지 확인 (중복이면 true이므로 이 조건에 걸려서 다음 로직 실행 안됨)

        candidatorList[_indexOfCandidator].upVote++;

        Voted[msg.sender] = true; // ★ msg.sender: 솔리디티의 특별한 변수. 이 변수는 메시지를 보낸 사람의 address를 가지고 있음. vote를 한 계정은 true로 바뀐다

        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }

    // 4) finish vote
    function finishVote() public onlyOwner{ // public 즉, 누구나 finish vote를 할 수 있으므로 modifier를 통해 이 contract를 만든 사람만 할 수 있도록 지정한다
        live = false;

        emit FinishVote(live);
    }
}