// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721,Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private currentTokenId;
    /// @dev Base token URI used as a prefix by tokenURI().
    string public baseTokenURI;
    uint256 maxNftAmount;
    constructor() ERC721("BLACKROK", "BROK") {
      baseTokenURI = "https://gateway.pinata.cloud/ipfs/bafybeif7blxszk2duoyqrbygqcs7xr7bmjoaflxuhkmdks26cr5bubjvri/";
       maxNftAmount = 888;
    }
    
    function contractURI() public pure returns (string memory) {
       return "https://gateway.pinata.cloud/QmRvrmgmWPUBTzgzcDEjB1jY6goa4x4K9GiDbb8djwqaXi";
    }

    function mintAll() public onlyOwner returns (uint256) {
      for(uint i=0; i<maxNftAmount; i++){
         require(currentTokenId.current() < maxNftAmount);
         currentTokenId.increment();
          uint256 newItemId = currentTokenId.current();
          _safeMint(address(msg.sender), newItemId);
      }
      return maxNftAmount;
    }
  
    /// @dev Returns an URI for a given token ID
    function _baseURI() internal view virtual override returns (string memory) {
      return baseTokenURI;
    }

    /// @dev Sets the base token URI prefix.
    function setBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
      baseTokenURI = _baseTokenURI;
    }

    function totalMinted() public view returns (uint) {
       return currentTokenId.current();
    }

}
