//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract BloodDonation{
    //register struct array
    //get all data 
    //get specific data
    //blood donation transaction

    address owner ;


    event success(
        string message
    );

    modifier isOwner{
        require(owner == msg.sender, "your not the owner, Don't overact");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    struct BloodTransactionStruct{
        string patientType;
        uint time;
        address from;
        address to;
    }

    struct PatientStruct{
        string name;
        uint age;
        string bloodgroup;
        uint phNo;
        uint aadhaarNo;
        BloodTransactionStruct[] bt;
    }

    PatientStruct[] patients;
    mapping(uint => uint) patientIndex;

    function register(string memory _name, uint _age, string memory _bloodgroup, uint _phNo, uint _aadhaarNo) public isOwner {
        

        uint index = patients.length;

        patients.push();
        patients[index].name = _name;
        patients[index].age = _age;
        patients[index].bloodgroup = _bloodgroup;
        patients[index].phNo = _phNo;
        patients[index].aadhaarNo = _aadhaarNo;

        patientIndex[_aadhaarNo] = index;

        emit success("patient registered successfully");
        
    }

    function getAllData() public view returns(PatientStruct[] memory){
        return patients;
    }

    function getSpecficPatientData(uint _aadhaarNo) public view returns(PatientStruct memory){
        uint index = patientIndex[_aadhaarNo];
        return patients[index];
    }


    function BloodTransaction(uint _aadhaarNo, address _from, address _to, string memory _type) public isOwner {
        uint index = patientIndex[_aadhaarNo];
        patients[index].bt.push(BloodTransactionStruct({patientType: _type, time: block.timestamp, from: _from, to: _to}));
        emit success("blood transaction done");
    } 

    




}
