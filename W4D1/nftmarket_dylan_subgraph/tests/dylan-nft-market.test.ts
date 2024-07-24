import {
  assert,
  describe,
  test,
  clearStore,
  beforeAll,
  afterAll
} from "matchstick-as/assembly/index"
import { Bytes, Address, BigInt } from "@graphprotocol/graph-ts"
import { Cancel } from "../generated/schema"
import { Cancel as CancelEvent } from "../generated/Dylan_NFTMarket/Dylan_NFTMarket"
import { handleCancel } from "../src/dylan-nft-market"
import { createCancelEvent } from "./dylan-nft-market-utils"

// Tests structure (matchstick-as >=0.5.0)
// https://thegraph.com/docs/en/developer/matchstick/#tests-structure-0-5-0

describe("Describe entity assertions", () => {
  beforeAll(() => {
    let orderHashId = Bytes.fromI32(1234567890)
    let newCancelEvent = createCancelEvent(orderHashId)
    handleCancel(newCancelEvent)
  })

  afterAll(() => {
    clearStore()
  })

  // For more test scenarios, see:
  // https://thegraph.com/docs/en/developer/matchstick/#write-a-unit-test

  test("Cancel created and stored", () => {
    assert.entityCount("Cancel", 1)

    // 0xa16081f360e3847006db660bae1c6d1b2e17ec2a is the default address used in newMockEvent() function
    assert.fieldEquals(
      "Cancel",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "orderHashId",
      "1234567890"
    )

    // More assert options:
    // https://thegraph.com/docs/en/developer/matchstick/#asserts
  })
})
