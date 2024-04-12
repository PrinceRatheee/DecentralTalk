const hre=require("hardhat");

async function main(){
    const Upload=await hre.ethers.getContractFactory("ChatApp");
    const upload=await Upload.deploy();

    await upload.deployed();

    console.log("Libraryy deployed to:" , upload.address);

}

main().catch((error)=>{
    console.error(error);
    process.exitCode=1;
});