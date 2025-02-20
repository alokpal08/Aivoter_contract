pragma solidity ^0.8.0;

contract AIVotingAdvisor {
    struct Proposal {
        string name;
        uint256 voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;
    address public owner;

    constructor() {
        owner = msg.sender;
        proposals.push(Proposal("Proposal 1", 0));
        proposals.push(Proposal("Proposal 2", 0));
        proposals.push(Proposal("Proposal 3", 0));
    }

    function vote(uint256 proposalIndex) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(proposalIndex < proposals.length, "Invalid proposal index.");
        
        proposals[proposalIndex].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function getWinningProposal() public view returns (string memory) {
        uint256 winningVoteCount = 0;
        uint256 winningIndex = 0;
        
        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningIndex = i;
            }
        }
        return proposals[winningIndex].name;
    }

    function aiAdvisor() public view returns (string memory) {
        if (proposals.length == 0) {
            return "No proposals available.";
        }

        uint256 totalVotes = 0;
        for (uint256 i = 0; i < proposals.length; i++) {
            totalVotes += proposals[i].voteCount;
        }
        
        if (totalVotes == 0) {
            return "No votes yet. AI suggests waiting for more participation.";
        }
        
        return string(abi.encodePacked("AI suggests voting for: ", getWinningProposal()));
    }
}
