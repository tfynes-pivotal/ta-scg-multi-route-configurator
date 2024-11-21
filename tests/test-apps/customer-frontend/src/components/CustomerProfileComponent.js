import React from "react";
import CustomerProfileService from "../services/CustomerProfileService";

class CustomerProfileComponent extends React.Component {

   constructor(props) {
    super(props);
    this.state = { 
        customerprofiles:[]
    }
   } 

   componentDidMount(){
    CustomerProfileService.getCustomerProfiles().then((response) => {
        this.setState({customerprofiles: response.data})
    });
   }

   render() {
    return (
    <div>
        <h1 className = "text-center">Customer List</h1>
        <table className = "table table-striped">
            <thead>
                <tr>
                <td> Customer Id</td>
                <td> Customer First Name</td>
                <td> Customer Last Name</td>
                <td> Customer Email</td>
                </tr>
            </thead>
            <tbody>
                {
                    this.state.customerprofiles.map(
                        customerprofile => 
                        <tr key = {customerprofile.id}>
                            <td> {customerprofile.id}</td>
                            <td> {customerprofile.firstName}</td>
                            <td> {customerprofile.lastName}</td>
                            <td> {customerprofile.email}</td>
                        </tr>
                    )
                }
            </tbody>
        </table>
    </div>
    )
   }

}

export default CustomerProfileComponent