// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract JobPortal {

    enum JobSeekerStatus{
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

    struct Recruiter {
        string Name;
        string Email;
        string Phone;
        string Organization;
        string Address;

        uint[] PositionKeys;
    }

    struct Candidate{
        string Name;
        string Email;
        string Phone;
        string Skills;
        string CandidateAddress;        
        
        uint8 Experience;
    }

    struct Position{
        string Title;
        string Skills;
        string Description;
        
        PositionSite Site;
        PositionStatus Status;
        PositionType PositionType;

        address[] AppliedCandidates;
    }

    mapping (uint => Position) private Positions;
    mapping (address => Candidate) private Candidates;
    mapping (address => Recruiter) private JobRecruiters;   
    
    address[] private RecruiterKeys;
    address[] private CandidateKeys;

    function RegisterRecruiter(address walletAddress, string memory name, string memory email, string memory phone, string memory organization, string memory companyAddress)
    public {
        JobRecruiters[walletAddress].Name = name;
        JobRecruiters[walletAddress].Email = email;
        JobRecruiters[walletAddress].Phone = phone;
        JobRecruiters[walletAddress].Organization = organization; 
        JobRecruiters[walletAddress].Address = companyAddress;
        RecruiterKeys.push(walletAddress);
    }

    function GetRecruiter(address walletAddress) public view returns (string memory, string memory, string memory, string memory, string memory) {
        unchecked {
            return (
                JobRecruiters[walletAddress].Name,
                JobRecruiters[walletAddress].Email,
                JobRecruiters[walletAddress].Phone,
                JobRecruiters[walletAddress].Organization,
                JobRecruiters[walletAddress].Address
            );
        }
    }

    function GetRecruiters() public view returns(Recruiter[] memory){
        unchecked {
            uint count = RecruiterKeys.length;
            Recruiter[] memory recruiters = new Recruiter[](count);
            for(uint index = 0; index < count; index++) {
                recruiters[index] = JobRecruiters[RecruiterKeys[index]];
            }
            return recruiters;
        }        
    }

    function PostJob(address recruiterAddress, uint256 id, string memory title, string memory description, string memory skills, PositionStatus status, PositionSite site, PositionType positionType)
    public
    {
        unchecked
        {
            Positions[id].Site = site;
            Positions[id].Title = title;
            Positions[id].Skills = skills;
            Positions[id].Status = status;
            Positions[id].Description = description;
            Positions[id].PositionType = positionType;

            JobRecruiters[recruiterAddress].PositionKeys.push(id);
        }
    }

    function GetJobPostsByRecruiter(address recruiterAddress) public view returns (Position[] memory)
    {
        unchecked
        {
            uint count = JobRecruiters[recruiterAddress].PositionKeys.length;
            Position[] memory positions = new Position[](count);

            for (uint index = 0; index < count; index++)
            {
                positions[index] = Positions[JobRecruiters[recruiterAddress].PositionKeys[index]];
            }
            return positions;
        }
    }

    function RegisterCandidate(address walletAddress, string memory name, string memory email, string memory candidateAddress, string memory phone, string memory skills, uint8 experience)
    public
    {
        unchecked
        {
            Candidates[walletAddress].Name = name;
            Candidates[walletAddress].Email = email;
            Candidates[walletAddress].Phone = phone;
            Candidates[walletAddress].Skills = skills;
            Candidates[walletAddress].Experience = experience;
            Candidates[walletAddress].CandidateAddress = candidateAddress;
            CandidateKeys.push(walletAddress);
        }
    }

    function Apply(address candidateAddress, uint positionID) public
    {
        unchecked
        {
            Positions[positionID].AppliedCandidates.push(candidateAddress);
        }
    }

    function GetCandidatesByJob(address recruiterAddress, uint positionID) public view returns (Candidate[] memory)
    {
        unchecked
        {
            address[] memory appliedCandiateKeys = Positions[JobRecruiters[recruiterAddress].PositionKeys[positionID]].AppliedCandidates;
            uint count = appliedCandiateKeys.length;
            Candidate[] memory appliedCandiates = new Candidate[](count);

            for(uint index = 0; index < count; index++)
            {
                appliedCandiates[index] = Candidates[appliedCandiateKeys[index]];
            }

            return appliedCandiates;
        }
    }
}