import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { ERC20Sell } from "@typechain-types/contracts";
import { BigNumber } from "ethers";

describe("ERC20Sell", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshopt in every test.
  async function deployOneYearLockFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const ERC20SellFactory = await ethers.getContractFactory("ERC20Sell");
    const erc20Sell = await ERC20SellFactory.deploy() as ERC20Sell;

    return { erc20Sell, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should emit 1000 tokens", async function () {
      const { erc20Sell } = await loadFixture(deployOneYearLockFixture);

      expect(await erc20Sell.totalSupply()).to.equal(BigNumber.from(1000).mul(BigNumber.from(10 ** 18)));
    });

    it("Should have decimals of 18", async function () {
      const { erc20Sell } = await loadFixture(deployOneYearLockFixture);

      expect(await erc20Sell.decimals()).to.equal(18);
    });

  });

  describe("Sell tokens", function () {
    it("Should calc the cost of amount", async function () {
      const { erc20Sell } = await loadFixture(deployOneYearLockFixture);
    
      const ethPrice = await erc20Sell.getOnlyEthPrice();
      console.log("ethPrice", ethPrice);
      const tokenPrice = await erc20Sell.tokenPrice();
      console.log("tokenPrice", tokenPrice);
      const amount = 1e18;
      const cost = await erc20Sell.getCostOf(amount);

      await expect(cost).to.be.equal(BigNumber.from(amount).mul(tokenPrice).div(ethPrice));
    });
  });
});
