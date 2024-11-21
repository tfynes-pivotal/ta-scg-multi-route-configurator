import axios from 'axios'
import { useEffect } from 'react';

//const CUSTOMERPROFILE_REST_API_URL = 'https://customer-profile2.homelab.fynesy.com/api/customer-profiles';
//const CUSTOMERPROFILE_REST_API_URL = 'https://customer-gateway.homelab.fynesy.com/api/customer-profiles';


const CUSTOMERPROFILE_REST_API_URL = '/api/customer-profiles';



//class CustomerProfileService extends Component {
class CustomerProfileService {
    // constructor(props){
    //     super(props);
    //     this.state = {
    //         config: null,
    //         loading: true,
    //         error: null
    //     };
    // }
    getCustomerProfiles() {
        return axios.get(CUSTOMERPROFILE_REST_API_URL);
        //return axios.get(config.apiUrl);
    }
}

// componentDidMount() {
//     fetch('/config.json')
//     .then(response => {
//         if (!response.ok) {
//             throw new Error('network response bad');
//         }
//         return response.json();
//     })
//     .then(data => this.setState({config: data, loading: false }))
//     .catch(error => this.setState({ error, loading:false}));
// }

export default new CustomerProfileService();