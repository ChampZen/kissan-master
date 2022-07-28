pragma solidity ^0.4.25;

import "./LOAN.sol";

contract Insurance
{
    enum StateType {DocUploaded, Reviewed, Completed, Terminate, Drought, Flood}

    StateType public State;

    address public Farmerc;
    address public Administrator;
    int public InsuranceAmount;
    address public Insurerc;
    string public InsuranceNo;
    string public StartDate;
    string public EndDate;
    string public lat;
    string public lon;
    int public FarmerIns;
    bool public rev;
    int public MonthTimePeriod;

    Loan LoanReq;

    address public CurrentContractAddress;

    constructor(address fmr, address ins, int iamt, string ino, int tp,string sd, string ed,string lt, string ln) public {
        Administrator = msg.sender;

        // ensure the two parties are different
        if ( ins == fmr) {
            revert();
        }

        Farmerc = fmr;
        Insurerc = ins;
        InsuranceAmount = iamt;
        InsuranceNo = ino;
        MonthTimePeriod = tp;
        StartDate = sd;
        EndDate = ed;
        lat = lt;
        lon = ln;
        FarmerIns = 0;
        CurrentContractAddress = address(this);
        rev = false;
        State = StateType.DocUploaded;
    }

    function changeTelemetry(int temp, int rain) public {
        if(temp>65) {
            FarmerIns = InsuranceAmount;
            InsuranceAmount = 0;
            State = StateType.Drought;
        }
        if(rain>35) {
            FarmerIns = InsuranceAmount;
            InsuranceAmount = 0;
            State = StateType.Flood;
        }
        
    }

    function Reviewed(int r) public
    {
        if (r == 1) {
            rev = true;
            State = StateType.Reviewed;
            //LoanReq = new Loan(CurrentContractAddress, Farmerc, Insurerc, InsuranceAmount, InsuranceNo, MonthTimePeriod, StartDate, EndDate, lat, lon);
        }

        if (r == 0) {
            rev = false;
            State = StateType.Terminate;
        }
    }

    function Expired() public
    {
        State = StateType.Completed;
    }
}
