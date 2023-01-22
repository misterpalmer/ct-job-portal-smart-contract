// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract jobPortal {
    
    /* Events */
    event PositionEvent(uint id, PositionStatus positionStatus, uint timeOfEvent);
    
    /* Enums / Structs */
    enum SeekerEmploymentStatus {
        SeekingEmployment,
        Employed
    }

    enum PositionStatus {
        Created,
        Available,
        Disabled,
        Fulfilled
    }

    enum PositionSite {
        FullRemote,
        PartialRemote,
        OnlyOnSite
    }

    enum PositionType {
        Contract,
        PartTime,
        W2
    }

    struct Recruiter {
        address id;
        string companyName;
        string companyLocation;
        string recruiterName;
        string website;
        string recruiterID;
    }

    struct PositionSeeker {
        address id;
        string personalLocation;
        string name;
        uint256 phoneNumber;
        string email;
    }

    struct Position {
        uint id;
        address recuiter;
        string title;
        string description;
        string requirements;
        string[] skills;
        PositionStatus status;
        PositionSite site;
        PositionType _type;
    }

    struct Candidate {
        address seeker;
        string positionId;
        string appliedDate;
    }

    // todo validate the approach of mapping and keys[]
    // https://hackmd.io/@totomanov/gas-optimization-loops
    mapping (uint256 => Recruiter) public recruiters;
    address[] recruiterKeys;

    mapping (uint256 => PositionSeeker) public seekers;
    uint256[] positionKeys;

    mapping (uint256 => Position) public positions;
    Position[] positionList; 

    mapping (uint256 => Candidate) public candidates;

/*
    function registerJobSeeker (jobSeeker memory _jobSeeker, string memory name, uint index) public {
        jobSeekers[index] = _jobSeeker;
    }
*/
    function createPosition (
        address recruiter,
        string memory title,
        string memory description,
        string memory requirements,
        string[] memory skills,
        PositionSite positionSite,
        PositionType positionType
    ) public {
        Position memory position = 
            Position(positionList.length,
                recruiter,
                title,
                description,
                requirements,
                skills,
                PositionStatus.Created,
                positionSite,
                positionType
            );

        positionList.push(position); 
        recruiterKeys.push(recruiter);
        emit PositionEvent(position.id, position.status, block.timestamp);
        // todo create an event in order to let the web3 clients to get noitifications when a job was created
    }

    function getPositions() public view returns(Position[] memory ) {
        return positionList;
    } 

    function getAvailablePositions() public view returns (Position[] memory ) {
        Position[]  memory  availablePosition;

        for(uint i = 0; i < positionList.length;)
        {
            uint j = 0;
            if (positionList[i].status == PositionStatus.Available) {
                 availablePosition[j] = positionList[i];
                 j++;
            }
            i++;
        }
        return availablePosition;
    }

    function changePositionStatus  (uint id, PositionStatus status ) public {
        // todo find the position and modify the status
        positions[id].status = status;
        emit PositionEvent(id, status, block.timestamp);
    }

    function getNumberOfPositions() public view  returns (uint) {
        return positionList.length;
    }
}