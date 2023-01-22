// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract jobPortal {
    event PositionEvent(string positionId, PositionStatus positionStatus,uint timeOfEvent);
    enum jobSeekerStatus{
        SeekingEmployment,
        Employed
    }

    enum PositionStatus{
        Created,
        Available,
        Disabled,
        Fulfilled
    }

    enum  PositionSite{
        FullRemote,
        PartialRemote,
        OnlyOnSite
    }

    enum PositionType {
        Contract,
        PartTime,
        W2
    }

    struct Recruiter{
        address walletAddress;
        string companyName;
        string companyLocation;
        string recruiterName;
        string website;
        string recruiterID;
    }

    struct PositionSeeker{
        address walletAddress;
        string personalLocation;
        string name;
        uint256 phoneNumber;
        string email;

        // jobSeekerStatus _jobSeekerStatus; // may need to check on the style of declaration here
    }

    struct Position{
        // 
        string id;
        address recuiterWalletAddress;
        string title;
        string description;
        string requirements;
        string[] skills;
        PositionStatus status;
        PositionSite site;
        PositionType _type;
    }

    struct Candidate{
        // candidates applying for the job
        string positionID;
       // string candidateAddress; We do not know the reason for this field, 
        string appliedDate;
        address jobSeekerWalletAddress;
    }

    // adding mapping for each of the structures
    mapping (uint256 => Recruiter) public jobRecruiters;
    mapping (uint256 => PositionSeeker) public jobSeekers;
    mapping (uint256 => Position) public availableJobs;
    uint256[] positionKey;
    string[] jobRecruitersKes;
    Position[] positions; 


    mapping (uint256 => Candidate) public jobCandidates;
/*
    function registerJobSeeker (jobSeeker memory _jobSeeker, string memory name, uint index) public {
        
        jobSeekers[index] = _jobSeeker;
        


    }
    */
    function createPosition (
      string memory id,
        address recuiterWalletAddress,
        string memory title,
        string memory description,
        string memory requirements,
        string[] memory skills,
        PositionSite positionSite,
        PositionType positionType

    ) public {
      Position memory newPosition= Position(id,
                            recuiterWalletAddress,title,description,requirements,skills,
                            PositionStatus.Created,
                            positionSite,
                            positionType
                            
                            );
        positions.push(newPosition)       ; 

        //ToDo Validate this approch   
        jobRecruitersKes.push(id);
          uint timeStamp= block.timestamp;
          //string positionId, PositionStatus positionStatus,uint timeOfEvent
          emit     PositionEvent(id,PositionStatus.Created,timeStamp);

        //ToDo  Create an event in order to let the web3 clients to get noitifications when a job was created        

    }
/*
1... 10M positions
20k New position
9M Filled 
10K Created position

*/

//return all position
    function getPositions() public view returns(Position[] memory ) {
        return positions;
    } 

    function getAvailablePositions() public  view returns (Position[] memory ) {
      Position[]  memory  availablePosition;
    uint j=0;// the position for the new array
        for(uint i=0;i<positions.length;i++)
        {
            if (positions[i].status==PositionStatus.Available){

                 availablePosition[j]=(positions[i]);
                 j++;
            }
        }
        return availablePosition;
    }

    function changePositionType  (string memory  positionId,PositionStatus newStatus ) public{
            
            //ToDo find the  position and modify the status
            
            uint timeStamp= block.timestamp;
            emit PositionEvent(positionId,newStatus,timeStamp);
    }

///All Dumy methods where we can create function for testings which we will deltele after


function getNumberOfPositions() public view  returns (uint){
    return positions.length;
}

    /**
     * @dev Store value in variable
 
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
    function retrieve() public view returns (uint256){
        return number;
    }
        * @param num value to store
     */
}