//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
import "./zombiehelper.sol";


contract ZombieAttack is ZombieHelper{

    uint randNonce = 0;
    uint attackVictoryProbability = 70;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce)))%_modulus;
    }

    function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
  
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100);
        if (rand <= attackVictoryProbability)
    {
      myZombie.winCount++;
      myZombie.level++;
      enemyZombie.lossCount++;
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    }
    else   
    {
        myZombie.lossCount++;
        enemyZombie.winCount++;    
    }
    _triggerCooldown(myZombie);
    }


}