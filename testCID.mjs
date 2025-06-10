import { CID } from 'multiformats/cid';

const cidv0 = CID.parse("IPFS_CID_HERE"); // Replace with your actual CID v0
const cidv1 = cidv0.toV1();
console.log(cidv1.toString()); 