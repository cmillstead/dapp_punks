import { useEffect, useState } from 'react';
import { Container, Row, Col } from 'react-bootstrap';
import Countdown from 'react-countdown';
import { ethers } from 'ethers';

// Components
import Navigation from './Navigation';
import Loading from './Loading';
import Data from './Data';

import NFT_ABI from '../abis/NFT.json';
import config from '../config.json';
import preview from '../preview.png';

function App() {
  const [provider, setProvider] = useState(null);
  const [nft, setNFT] = useState(null);
  const [account, setAccount] = useState(null);

  const [revealTime, setRevealTime] = useState(0);
  const [maxSupply, setMaxSupply] = useState(0);
  const [totalSupply, setTotalSupply] = useState(0);
  const [cost, setCost] = useState(0);
  const [balance, setBalance] = useState(0);

  const [isLoading, setIsLoading] = useState(true);

  const loadBlockchainData = async () => {
    // Initiate provider
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    setProvider(provider);

    // Initiate NFT contract
    const nft = new ethers.Contract(config[31337].nft.address, NFT_ABI, provider);
    setNFT(nft);

    // Fetch accounts
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
    const account = ethers.utils.getAddress(accounts[0]);
    setAccount(account);

    // fetch countdown
    const allowMintingOn = await nft.allowMintingOn();
    setRevealTime(allowMintingOn.toString() + '000');

    // fetch maxSupply
    setMaxSupply(await nft.maxSupply());

    // fetch totalSupply
    setTotalSupply(await nft.totalSupply());

    // fetch cost
    setCost(await nft.cost());

    // fetch balance
    setBalance(await nft.balanceOf(account));
    
    setIsLoading(false);
  }

  useEffect(() => {
    if (isLoading) {
      loadBlockchainData();
    }
  }, [isLoading]);

  return(
    <Container>
      <Navigation account={account} />

      <h1 className='my-4 text-center'>Dapp Punks</h1>

      {isLoading ? (
        <Loading />
      ) : (
        <>
          <Row>
            <Col>
              <img src={preview} alt='preview' className='img-fluid' />
            </Col>

            <Col>
              <div className='my-4 text-center'>
                <Countdown date={parseInt(revealTime)} className='h2' />
              </div>
              <Data 
                maxSupply={maxSupply} 
                totalSupply={totalSupply} 
                cost={cost} 
                balance={balance}
              />
            </Col>
          </Row>
        </>
      )}
    </Container>
  )
}

export default App;
