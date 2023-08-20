import { useState } from 'react';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import Spinner from 'react-bootstrap/Spinner';
import { ethers } from 'ethers';

const Mint = ({ provider, nft, cost, setIsLoading }) => {
    const [isWaiting, setIsWaiting] = useState(false);

    const mintHandler = async (e) => {
        e.preventDefault();
        setIsWaiting(true);

        try {
            const signer = provider.getSigner();
            const transaction = await nft.connect(signer).mint(1, { value: cost });
            await transaction.wait();
        } catch (err) {
            window.alert('User rejected or transaction reverted');
        }

        setIsLoading(true);
    };

    return (
        <Form onSubmit={mintHandler} style={{ maxWidth: '450px', margin: '50px auto' }}>
            {isWaiting ? (
                <Spinner animation='border' role='status'/>
            ) : (
                <Button variant='primary' type='submit' style={{ width: '100%' }}>
                    Mint for {ethers.utils.formatEther(cost)} ETH
                </Button>
            )}
        </Form>
    ); 
};

export default Mint;
