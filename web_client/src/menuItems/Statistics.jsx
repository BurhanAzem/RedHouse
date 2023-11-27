import React, { useContext, useEffect, useState } from 'react'
import '../styles/Admin.css'
import { useRecoilState } from 'recoil'
import axios from 'axios'
import { ToastContainer, toast } from 'react-toastify'
import { Link, Route, Routes, useNavigate, useParams } from 'react-router-dom'
import Counter from '../components/Counter.jsx'
import { AuthContext } from '../context/authContext.js'
import { Line } from "react-chartjs-2";
import 'chart.js/auto';
import Chart from "chart.js/auto";
import { CategoryScale } from 'chart.js/auto';
import Cookies from 'js-cookie'

Chart.register(CategoryScale);


const data = {
  labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
  datasets: [
    {
      label: "First dataset",
      data: [33, 53, 85, 41, 44, 65],
      fill: true,
      backgroundColor: "rgba(75,192,192,0.2)",
      borderColor: "rgba(75,192,192,1)",
      borderWidth: 2, // Adjust this value to change the line width
    },
    {
      label: "Second dataset",
      data: [33, 25, 35, 51, 54, 76],
      fill: false,
      borderColor: "#742774",
      borderWidth: 2, // Adjust this value to change the line width
    },
  ],
};


const Statistics = () => {
  const navigate = useNavigate()
  const { currentUser } = useContext(AuthContext)
  const [visits, setVisits] = useState(0)
  const [numberOfVolunteers, setNumberOfVolunteers] = useState(0)
  const [numberOfPosts, setNumberOfPosts] = useState(0)

  const getCookie = (cookieName) => {
    const cookieValue = Cookies.get(cookieName);
    return cookieValue;
  }

  const handleResetVisits = async () => {
    // Swal.fire({
    //   title: 'Are you sure you want to reset the number of visits?',
    //   showCancelButton: true,
    //   confirmButtonColor: '#00BF63',
    //   confirmButtonText: 'Reset',
    //   customClass: 'Custom_btn'
    // }).then(async (result) => {
    //   if (result.isConfirmed) {
    //     try {
    //       const res = await axios.delete("http://localhost:3007/api/auth/visits");
    //       if (res.status === 200) {
    //         Swal.fire('Success!', 'Number of visits has been reset.', 'success');
    //         // Optionally, you can update the UI to reflect the new state
    //         setVisits(0); // Assuming you have a state variable for visits
    //       } else {
    //         Swal.fire('Error', 'An error occurred while resetting visits.', 'error');
    //       }
    //     } catch (err) {
    //       if (err.message === 'Network Error' && !err.response) {
    //         toast.error('Network error - make sure the server is running!', {
    //           position: 'top-center',
    //           autoClose: 10000,
    //           hideProgressBar: false,
    //           closeOnClick: true,
    //           pauseOnHover: true,
    //           draggable: true,
    //           progress: undefined,
    //           theme: 'colored',
    //         });
    //       } else if (err.response && err.response.status === 401) {
    //         navigate('/login');
    //       } else {
    //         Swal.fire('Error', 'An error occurred while resetting visits.', 'error');
    //       }
    //       console.error(err);
    //     }
    //   } else if (result.isDenied) {
    //     Swal.fire('Cancelled', 'Changes are not saved', 'info');
    //   }
    // });
  };

 
  useEffect(() => {
    const fetchData = async () => {
      try {
        // Get the access token from a cookie named "access_token_tuulio"
        const currentCookie = getCookie("access_token_tuulio");

        // Check if the access token is available
        if (!currentCookie) {
          // Handle the case where the access token is missing or undefined
          console.log("Access token is missing.");
        }

        // Make an authenticated request using the access token
        const res = await axios.get(`${process.env.REACT_APP_BASE_URL}/verifyUser/${currentCookie}`);

        // Process the response data if needed

        // Example: Log the response data
        console.log("Response data:", res.data);
      } catch (err) {
        if (err.message === 'Network Error' && !err.response) {
          // Handle network error
          toast.error('Network error - make sure the server is running!', {
            position: "top-center",
            autoClose: 10000,
            hideProgressBar: false,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "dark",
          });
        } else if (err.response && err.response.status === 401) {
          // Handle unauthorized access (status code 401)
          if (currentUser) {
            console.log("Unauthorized access - redirecting to login.");
            navigate('/login');
          }
        } else {
          // Handle other errors
          console.error("An error occurred:", err);
        }
      }
    };
    const getVisits = async () => {
      try {
        const res = await axios.get(`${process.env.REACT_APP_BASE_URL}/auth/visits`);
        setVisits(res.data)
        console.log(res);
      } catch (err) {
        if (err && err.message == 'Network Error' && !err.response)
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
        if (err && err.response.status == 401) {
          navigate('/login')
        }
        console.log(err)
      }
    }

    const getNumberOfPosts = async () => {
      try {
        const res = await axios.get(`${process.env.REACT_APP_BASE_URL}/posts/numberOfPosts`);
        setNumberOfPosts(res.data)
        console.log(res);
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
        if (err.response.status == 401) {
          navigate('/login')
        }
        console.log(err)
      }
    }


    const getNumberOfVolunteers = async () => {
      try {
        const result = await axios.get(`${process.env.REACT_APP_BASE_URL}/users/usersNumber`);
        setNumberOfVolunteers(result.data.total)
        console.log(result);
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
        if (err.response.status == 401) {
          navigate('/login')
        }
        console.log(err)
      }
    }
    // fetchData()
    // getVisits()
    // getNumberOfVolunteers()
    // getNumberOfPosts()
  }, []);
  // useEffect(() => {
  //   // Scroll to the top of the page when the component mounts

  //   setTimeout(function () {
  //     window.scrollTo(0, 0);
  // },2);
  // }, []);

  

  return (
    <>
      <div style={{ height: "10px" }}></div>
      <div style={{ height: "10px" }}></div>
      <div style={{ height: "10px" }}></div>
      <div style={{ height: "10px" }}></div>

      <div className="row" id='statistics'>
        <div className="col-md-3">
          <div className="l-number">Number of users</div>
          <div className="number"><Counter target={numberOfVolunteers && numberOfVolunteers} /></div>
        </div>
        <div className="col-md-3" id='create-number'>
          <div className="l-number">Number of properties</div>
          <div className="number"><Counter target={numberOfPosts && numberOfPosts} /></div>
        </div>

        <div className="col-md-3" id='create-number'>
          <div className="l-number">Number of contracts</div>
          <div className="number"><Counter target={numberOfPosts && numberOfPosts} /></div>
        </div>
      </div>

      <div style={{ height: "10px" }}></div>


      <div className="row" id='statistics'>
        <div className="col-md-3">
          <div className="l-number">Number of offers</div>
          <div className="number"><Counter target={numberOfVolunteers && numberOfVolunteers} /></div>
        </div>

        <div className="col-md-3">
          <div className="l-number">Number of visits</div>
          <div className="number"><Counter target={visits && visits} /></div>
          <div className="reset">
            <button onClick={handleResetVisits} id='reset-visits' required autoComplete='off'>Reset number of visits</button>
          </div>
        </div>

        <div className="col-md-3">
          <div className="l-number">Number of applications</div>
          <div className="number"><Counter target={visits && visits} /></div>
        </div>

      </div>


      <hr style={{ width: "1500px", display: "flex", justifyContent: "center", alignItems: "center", marginLeft: "140px" }} />

      <div style={{ paddingRight: "0px" }}>
          <div className="l-search" style={{margin: "40px"}}>Properties / Time</div>
        <div className="items" style={{height: "400px"}}>
          <Line aria-setsize={{}} data={data} />
        </div>
          <div className="l-search" style={{margin: "40px"}}>Users / Time</div>
        <div className="items" style={{height: "400px"}}>
          <Line aria-setsize={{}} data={data} />
        </div>

      </div>
    </>


  )
}

export default Statistics



{/* <div style={{ paddingRight: "120px" }}>
            <div className="row">
              <div className="l-search">Search about student</div>
            </div>
            <div className="items">

              <div className="container" id='row-items'>
                <div className="row" id='search-bar-up'>
                  <SearchBar admin={true} />
                </div>
                <div className="row" id='search-bar-below'>

                  <div className="col-md-6" id='filter-bar-container'>
                    <FilterBar placeholder='Select student language' options={languageOptions} filterType="language" />
                  </div>
                </div>
              </div>

            </div>
          </div> */}



{/* <UserList /> */ }
{/* <hr className='student-bar' /> */ }
{/* <Footer /> */ }