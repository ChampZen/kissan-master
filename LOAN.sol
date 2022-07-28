pragma solidity ^0.4.25;

import "./BAIL.sol";

contract Loan
{
    enum StateType {ReqAmount, AcceptBids1, AcceptBids2, AcceptBids3, FinalizeBids, Monitor, Calamity, Harvested}

    StateType public State;

    address public Farmerc;
    address public investor;
    
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
    int public loanAmountReq;

    int public loanAmount1;
    int public intRate1;
    int public intrestAmount1;

    int public loanAmount2;
    int public intRate2;
    int public intrestAmount2;

    int public loanAmount3;
    int public intRate3;
    int public intrestAmount3;

    int public AmountReturned;
    int public LoanTimePeriod;
    Insurance LandInsurance;

    int public MonthTimePeriod;

    address public CurrentContractAddress;
    address parentContractAddress;

    address public Investor1;
    address public Investor2;
    address public Investor3;

    string public status;

    int public LoanReturns1;
    int public LoanReturns2;
    int public LoanReturns3;
    

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
        State = StateType.ReqAmount;
    }


    function setLoanAmount(int r,int ltp) public
    {
        loanAmountReq = r;
        LoanTimePeriod = ltp;
        State = StateType.AcceptBids1;
        status = "Requested Loan";
    }

    function makeBid1(int lamt, int intrest) public
    {
        intRate1 = intrest;
        loanAmount1 = lamt;
        intrestAmount1 = (lamt*intrest*LoanTimePeriod)/100;
        State = StateType.AcceptBids2;
        status = "Total Bids = 1";
    }

    function makeBid2(int lamt, int intrest) public
    {
        intRate2 = intrest;
        loanAmount2 = lamt;
        intrestAmount2 = (lamt*intrest*LoanTimePeriod)/100;
        State = StateType.AcceptBids3;
        status = "Total Bids = 2";
    }

    function makeBid3(int lamt, int intrest) public
    {
        intRate3 = intrest;
        loanAmount3 = lamt;
        intrestAmount3 = (lamt*intrest*LoanTimePeriod)/100;
        State = StateType.FinalizeBids;
        status = "Total Bids = 3";
    }

    function monitorIns(int code) public
    {
        if(code == 1) {
            status = "Crops Harvested Sucessfully !";
            State = StateType.Harvested;
        }
        if(code == 2) {
            status = "Crops Ruined due to floods Insurance amount received.";
            State = StateType.Calamity;
        }
        if(code == 3) {
            status = "Crops Ruined due to drought Insurance amount received.";
            State = StateType.Calamity;
        }
    }

    function finalizeBids(int bid1, int bid2, int bid3) public
    {
        if(bid1 == 1) {
            LoanReturns1 = intrestAmount1+loanAmount1;
        }
        if(bid2 == 1) {
            LoanReturns2 = intrestAmount2+loanAmount2;
        }
        if(bid3 == 1) {
            LoanReturns3 = intrestAmount2+loanAmount3;
        }
        State = StateType.Monitor;
    }



}
