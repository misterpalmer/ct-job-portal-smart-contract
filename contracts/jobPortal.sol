// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract jobPortal {

    enum jobSeekerStatus{
        SeekingEmployment,
        Employed
    }

    enum jobStatus{
        Created,
        Available,
        Disabled,
        Fulfilled
    }

    enum  workSite{
        FullRemote,
        PartialRemote,
        OnlyOnSite
    }

    enum jobType {
        Contract,
        PartTime,
        W2
    }

    struct jobRecruiter{
        string companyName;
        string companyAddress;
        string recruiterName;
        string website;
        string recruiterID;
    }

    struct jobSeeker{
        string personalAddress;
        string name;
        uint256 phoneNumber;
        string email;
        string jobSeekerID;
        // jobSeekerStatus _jobSeekerStatus; // may need to check on the style of declaration here
    }

    struct availableJob{
        // 
        string positionID;
        string positionTitle;
        string recuiter;
        string positionDescription;
        string positionRequirements;
        jobStatus _jobStatus;
        workSite _workSite;
        jobType _jobType;
    }

    struct jobCandidate{
        // candidates applying for the job
        string positionID;
        string candidateAddress;
        string appliedDate;
        string jobSeekerID;
    }

    // adding mapping for each of the structures
    mapping (uint256 => jobRecruiter) public jobRecruiters;
    mapping (uint256 => jobSeeker) public jobSeekers;
    mapping (uint256 => availableJob) public availableJobs;
    mapping (uint256 => jobCandidate) public jobCandidates;

    function registerJobSeeker (jobSeeker memory _jobSeeker, string memory name, uint index) public {
        
        jobSeekers[index] = _jobSeeker;
        
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