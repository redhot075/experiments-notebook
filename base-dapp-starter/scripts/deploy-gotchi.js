import hre from "hardhat";

async main() {
  console.log("Deploying ClawGotchi to Base Sepolia...");

  const ClawGotchi = await hre.ethers.getContractFactory("ClawGotchi");
  const gotchi = await ClawGotchi.deploy();
  await gotchi.waitForDeployment();

  const address = await gotchi.getAddress();
  console.log("ClawGotchi deployed to:", address);

  const ownerAddress = "0x87eE46B5ddF81d969bD0b6d8796542140DAB2A55";
  console.log("Transferring ownership to:", ownerAddress);
  await gotchi.transferOwnership(ownerAddress);
  console.log("Ownership transferred.");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
