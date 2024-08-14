import asyncio
from web3 import AsyncWeb3

async def test():
    w3 = AsyncWeb3(AsyncWeb3.AsyncHTTPProvider('http://localhost:8545'))
    result = await w3.is_connected()
    print(result)

    block = await w3.eth.get_block('latest')
    print(block)

# Create an event loop
loop = asyncio.get_event_loop()

# Use the event loop to run the test function
loop.run_until_complete(test())