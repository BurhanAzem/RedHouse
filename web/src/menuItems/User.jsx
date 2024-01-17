import React, { useContext, useEffect, useState } from 'react'
import '../styles/Student.css'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faPlay } from '@fortawesome/free-solid-svg-icons'
import { Link, Outlet, useNavigate, useParams } from 'react-router-dom'
import { useRecoilState } from 'recoil'
import { isCreatingPost, selectedUser, usersRows, viewingPostDetails } from '../state'
import axios from 'axios'
import { AuthContext } from '../context/authContext'
import { ToastContainer, toast } from 'react-toastify'
import Cookie from 'js-cookie'

import Popup from 'reactjs-popup';
import 'reactjs-popup/dist/index.css';

import "bootstrap/dist/css/bootstrap.min.css";
// Bootstrap Bundle JS
import "bootstrap/dist/js/bootstrap.bundle.min";

const User = () => {
  const { currentUser, logout } = useContext(AuthContext)
  const [isCreating, setIsCreating] = useRecoilState(isCreatingPost)
  const [isCreatingLocal, setIsCreatingLocal] = useState(false);

  const [isViewingPostDetails, setIsViewingPostDetails] = useRecoilState(viewingPostDetails)
  const [isViewingPostDetailsLocal, setIsViewingPostDetailsLocal] = useState(false)
  const [isMounted, setIsMounted] = useState(true);
  const navigate = useNavigate()
  const params = useParams();
  const [users, setUsers] = useRecoilState(usersRows);
  const [userData, setUserData] = useRecoilState(selectedUser)
  const [userId, setUserId] = useState({});



  const getCookie = (cookieName) => {
    const cookieValue = Cookie.get(cookieName);
    return cookieValue;
  }

  useEffect(() => {
    // Scroll to the top of the page when the component mounts

    console.log(userData)
  }, []);

  // useEffect(() => {
  //   console.log(users);
  //   console.log(params.id);
  //   setUserId(atob(params.id))
  //   setUserData(prevContractData => {
  //     const selectedUser = users.find(user => user.id == atob(params.id));
  //     console.log(selectedUser);
  //     return selectedUser;
  //   });
  // }, [params]);
  useEffect(() => {

    const fetchUserData = async () => {
      try {
        console.log(atob(params.id));
        const res = await axios.get(`${process.env.REACT_APP_BASE_URL}/users/${atob(params.id)}`);
        setUserData(res.data.dto)
        console.log(userData);
        return
      } catch (err) {
        if (err.message == 'Network Error' && !err.response)
          toast.error('Network error - make sure server is running!', {
            position: "top-center",
            autoClose: 10000,
            hideProgressBar: false,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "dark",
          });
        else if (err.response && err.response.status === 401) {
          if (currentUser) {
            console.log(err + '---------------------------------------------------------------');
            navigate('/login');
          }

        }
        console.log(err);
      }
    };

    fetchUserData();
  }, [params]);







  return (
    <>
      <div style={{
        display: "flex",
        justifyContent: "center"
      }}>
        <div style={{  borderRadius: "60px", padding: "20px", margin: "80px", width: "40%", boxShadow: "0.2px 0.5px 20px 0.1px", justifyContent: "center", justifyItems: "center" }}>
          <ToastContainer />
          <div className='row' >
            <div className='pic'>
              {<img src={require('../assets/user-pic.png')} alt="" id="profile-pic" />}

              <Link to="./"
                onClick={() => {
                  console.log(isCreating)
                  setIsCreatingLocal(false);
                }} id='username-link'>
                <h5 className="user-name" id='user-name'>
                  {userData && userData.name}
                </h5>
              </Link>
            </div>

            {/* <div className="col-md-1 zero-width vertical-line"></div> */}


          </div>
          <div className='row' style={{ textAlign: "center", marginTop: "10px" }}>
            <div className="language" style={{ marginBottom: "10px" }}>
              <span style={{ fontSize: "20px", fontWeight: "700" }}>User Role (level): </span>
              <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData && userData.userRole}</span>
            </div>

            <div className="language" style={{ marginBottom: "10px" }}>
              <span style={{ fontSize: "20px", fontWeight: "700" }}>Customer Score : </span>
              <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData && userData.customerScore}</span>
            </div>

            <div className="language" style={{ marginBottom: "10px" }}>
              <span style={{ fontSize: "20px", fontWeight: "700" }}>Landlord Score : </span>
              <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData && userData.customerScore}</span>
            </div>

            <div className="language" style={{ marginBottom: "10px" }}>
              <span style={{ fontSize: "20px", fontWeight: "700" }}>Email: </span>
              <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData && userData.email}</span>
            </div>

            <div className="language" style={{ marginBottom: "10px" }}>
              <span style={{ fontSize: "20px", fontWeight: "700" }}>Phone Number: </span>
              <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData && userData.phoneNumber}</span>
            </div>


            <div className="language" style={{ marginBottom: "10px" }}>
              <span style={{ fontSize: "20px", fontWeight: "700" }}>IsVerifed: </span>
              <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData && userData.isVerified ? "Yes" : "No"}</span>
            </div>

            <div className="language" style={{ marginBottom: "10px" }}>
              <span style={{ fontSize: "20px", fontWeight: "700" }}>Created Date: </span>
              <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData && userData.created}</span>
            </div>

            <div className="language" style={{ marginBottom: "10px" }}>
              <span style={{ fontSize: "20px", fontWeight: "700" }}>User Location (Postal Code): </span>
              <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData.location && userData.location.postalCode}</span>
            </div>
          </div>

          <div style={{ display: "flex", justifyContent: "center", justifyItems: "center", marginTop: "40px" }}>


            <Popup trigger={<span
              id='delete-post'
              style={{ borderStyle: "solid", backgroundColor: "black", borderColor: "black", color: "white", cursor: "pointer", width: "160px", textAlign: "center", fontWeight: "700", borderRadius: "20px" }}
            >Update
            </span>} modal contentStyle={{ display: "flex", justifyContent: "center", borderRadius: "20px", width: "30%" }} position="top center">
              <form style={{width: "90%"}} >
                <div class="form-group">
                  <label for="exampleInputEmail1">Name</label>
                  <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email"></input>
                  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Email</label>
                  <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password"></input>
                </div>
                <div class="form-check">
                  <input type="checkbox" class="form-check-input" id="exampleCheck1"></input>
                  <label class="form-check-label" for="exampleCheck1">Check me out</label>
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1"></label>
                  <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password"></input>
                </div>
                <div class="form-check">
                  <input type="checkbox" class="form-check-input" id="exampleCheck1"></input>
                  <label class="form-check-label" for="exampleCheck1">Check me out</label>
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Password</label>
                  <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password"></input>
                </div>
                <div class="form-check">
                  <input type="checkbox" class="form-check-input" id="exampleCheck1"></input>
                  <label class="form-check-label" for="exampleCheck1">Check me out</label>
                </div>

                <div style={{display: "flex", justifyContent: "center", marginTop: "20px"}}><button type="submit" class="btn" style={{ backgroundColor: "black", color: "white", width: "160px", textAlign: "center", fontWeight: "700", borderRadius: "20px" }}>Save</button></div>
              </form>
            </Popup>


            <Popup trigger={<span
              id='delete-post'
              style={{ borderStyle: "solid", backgroundColor: "white", borderColor: "black", color: "black", height: "35px", cursor: "pointer", width: "160px", textAlign: "center", fontWeight: "700", borderRadius: "20px" }}
            >Delete
            </span>} position="top center">
              <div>Popup content here !!</div>
            </Popup>

          </div>


        </div>
      </div>
    </>



  )
}

export default User