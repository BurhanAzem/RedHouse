import React, { useContext, useEffect, useState } from 'react'
import { MDBFooter, MDBContainer, MDBRow, MDBCol, MDBIcon } from 'mdb-react-ui-kit';
import '../styles/FileItem.css'
import { faFileAlt, faSpinner, faTrash, faX } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { Link, Outlet, useNavigate } from 'react-router-dom'
import '@fortawesome/fontawesome-free/css/all.min.css';
import 'bootstrap-css-only/css/bootstrap.min.css';
import 'mdbreact/dist/css/mdb.css';
import '../styles/Post.css'
import { AuthContext } from '../context/authContext';
import axios from 'axios';
import { useRecoilState } from 'recoil';
import { PostDetails, isCreatingPost, requests, requestsState, studentPosts } from '../state';
import { ToastContainer, toast } from 'react-toastify';
import profile_pic from '../assets/user-pic.png';
import DatePicker from 'react-date-picker';
import 'react-date-picker/dist/DatePicker.css';
import 'react-calendar/dist/Calendar.css';
import Swal from 'sweetalert2'

import { faFire } from '@fortawesome/free-solid-svg-icons'

// type ValuePiece = Date | null;

// type Value = ValuePiece | [ValuePiece, ValuePiece];

const PersonalVerificationRequest = ({ requestData }) => {

  const [value, onChange] = useState(new Date());

  const [requests, setRequests] = useRecoilState(requestsState);

  const navigate = useNavigate()
  const [categoriesPost, setCategoriesPost] = useState([])
  const [posts, setPosts] = useRecoilState(studentPosts)
  const [postDetails_, setPostDetails_] = useState(PostDetails)
  const [postDeta_, setPostDeta_] = useState()

  const Swal = require('sweetalert2')
  const [isCreating, setIsCreating] = useRecoilState(isCreatingPost)
  const { currentUser } = useContext(AuthContext)
  const [currentUrl, setCurrentUrl] = useState()
  const [isHaveAccount, setIsHaveAccount] = useState(true)



  const handleLinkClick = () => {
    setIsCreating((prev) => false);
    setPostDetails_(requestData && requestData);

    if (currentUser) {
      setIsHaveAccount(true);
    } else {
      setIsHaveAccount(false);
      Swal.fire({
        position: 'center',
        icon: 'info',
        confirmButtonColor: '#00BF63',
        title: 'To access study materials, you must log in to an account.',
        showConfirmButton: false,
        timer: 1500
      });
    }
  };




  const deleteComplaint = async () => {
    Swal.fire({
      title: 'Are you sure you want to delete this post?',
      showCancelButton: true,
      confirmButtonColor: '#00BF63',
      confirmButtonText: 'Delete',
      customClass: "Custom_btn"

    }).then(async (result) => {
      /* Read more about isConfirmed, isDenied below */
      if (result.isConfirmed) {
        Swal.fire('Done!', '', 'success')
        try {
          const res = await axios.delete(`${process.env.REACT_APP_BASE_URL}/complaints/${requestData.id}`);
          console.log(res.data)
          // console.log(res.data[0].id);
          const updatedPosts = posts.filter(complaint => complaint.id !== requestData.id)
          setPosts(updatedPosts)
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
              theme: "colored",
            });
          else if (err.response && err.response.status === 401) {
            navigate('/login');
          } else {
            console.log(err);
          }
        }
      } else if (result.isDenied) {
        Swal.fire('Changes are not saved', '', 'info')
      }
    })

  }

  const skipPost = async (postToSkip) => {
    console.log(posts);
    const updatedPosts = await posts.filter(post => post.id !== postToSkip.id);
    console.log(updatedPosts);
    setPosts(updatedPosts);
  };






  const approve = async (id) => {
    console.log(value);

    if (!value) {
      console.error("Date data is not available.");
      return;
    }

    try {
      const isoDateString = value.toLocaleString('en-US', { timeZone: 'UTC' });
      console.log(isoDateString);

      const res = await axios.post(`${process.env.REACT_APP_BASE_URL}/userIdentities/${id}/verify`);
      const updatedRequests = requests.filter(request => request.id !== id)
      setRequests(updatedRequests)
      // Assuming the response contains the updated post
      // Update the state with the updated post
    } catch (err) {
      if (err.message === 'Network Error' && !err.response) {
        toast.error('Network error - make sure the server is running!', {
          position: "top-center",
          autoClose: 10000,
          hideProgressBar: false,
          closeOnClick: true,
          pauseOnHover: true,
          draggable: true,
          progress: undefined,
          theme: "colored",
        });
      } else if (err.response && err.response.status === 401) {
        navigate('/login');
      } else {
        console.log(err);
      }
    }
  };


  const reject = async (id) => {
    console.log(value);

    if (!value) {
      console.error("Date data is not available.");
      return;
    }

    try {
      const isoDateString = value.toLocaleString('en-US', { timeZone: 'UTC' });
      console.log(isoDateString);

      const res = await axios.post(`${process.env.REACT_APP_BASE_URL}/userIdentities/${id}/reject`);
      const updatedRequests = posts.filter(request => request.id !== id)
      setRequests(updatedRequests)
      // Assuming the response contains the updated post
      // Update the state with the updated post
    } catch (err) {
      if (err.message === 'Network Error' && !err.response) {
        toast.error('Network error - make sure the server is running!', {
          position: "top-center",
          autoClose: 10000,
          hideProgressBar: false,
          closeOnClick: true,
          pauseOnHover: true,
          draggable: true,
          progress: undefined,
          theme: "colored",
        });
      } else if (err.response && err.response.status === 401) {
        navigate('/login');
      } else {
        console.log(err);
      }
    }
  };


  return (
    <div className="container" id='post'>
      <ToastContainer />
      <div className="row" id='post-up'>
        <div className="col-md-8">
          <div className="comment-image-container">

            <FontAwesomeIcon icon={faFire} style={{ fontSize: "28px" }} />

            <Link to='/' id='username-link'>
              <span className="comment-author date-name-group">{requestData && requestData.user.name}</span>
            </Link>
            <span className="created date-name-group">{requestData && requestData.complainDate ? requestData.complainDate.substring(0, 10) : null}</span>
          </div>
        </div>
        <div className="col-md-4" id='delete-lang-post'>

          <span id='delete-post'>
            <FontAwesomeIcon icon={faTrash}
              onClick={() => deleteComplaint()} />
          </span>


        </div>
      </div>


      <div className="post-down">
        <div onClick={handleLinkClick}>
          <div style={{fontWeight: "800"}}>Card ID</div>
          <div>
            {requestData.identityFiles && requestData.identityFiles.length > 0 && (
              <img
                style={{ width: '950px', marginTop: '20px' }}
                src={requestData.identityFiles[0].downloadUrls}
                alt=""
              />
            )}


          </div>
          <hr style={{marginTop: "40px"}}/>
          <div>
          <div style={{fontWeight: "800"}}>Personal pic</div>

            {requestData.identityFiles && requestData.identityFiles.length > 1 && (
              <img
                style={{ width: '950px', marginTop: '20px' }}
                src={requestData.identityFiles[0].downloadUrls}
                alt=""
              />
            )}
          </div>

        </div>
        <div className="change-date">
          <span><button id='update-btn' style={{ backgroundColor: "#00BF63" }} onClick={() => approve(requestData.id)}>Approve</button></span>
          <span><button id='update-btn' style={{ backgroundColor: "red" }} onClick={() => reject(requestData.id)}>Reject</button></span>

        </div>
      </div>
    </div >
  )
}

export default PersonalVerificationRequest