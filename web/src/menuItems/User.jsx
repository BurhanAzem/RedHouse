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
    <div className='container' id='student-container'>
      <ToastContainer />
      <div className='row' id={isViewingPostDetails ? 'disableRow' : 'profile-info'}>
        <div className='col-md-3' id='left-profile'>
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
        </div>

        {/* <div className="col-md-1 zero-width vertical-line"></div> */}

        <div className='col-md-8' id='right-profile'>
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
            <span style={{ fontSize: "20px", fontWeight: "700" }}>Added Date: </span>
            <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData && userData.created}</span>
          </div>

          <div className="language" style={{ marginBottom: "10px" }}>
            <span style={{ fontSize: "20px", fontWeight: "700" }}>User Location (Postal Code): </span>
            <span style={{ color: "#C4271B", fontWeight: "700", fontSize: "20px" }}>{userData.location && userData.location.postalCode}</span>
          </div>
        </div>
        <hr className='student-line'></hr>
      </div>

    </div>


  )
}

export default User