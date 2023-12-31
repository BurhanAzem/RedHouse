import React, { useContext, useEffect, useState } from 'react'
import '../styles/Student.css'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faPlay } from '@fortawesome/free-solid-svg-icons'
import { Link, Outlet, useNavigate, useParams } from 'react-router-dom'
import { useRecoilState } from 'recoil'
import { isCreatingPost, searchedDContracts, viewingPostDetails } from '../state'
import axios from 'axios'
import { AuthContext } from '../context/authContext'
import { ToastContainer, toast } from 'react-toastify'
import Cookie from 'js-cookie'
import FilterBar from '../components/SearchBar/FilterBar'
import SearchBar from '../components/SearchBar/SearchBar'

import "bootstrap/dist/css/bootstrap.min.css";
import ReactPaginate from "react-paginate";
import '../styles/UserList.css'
import { categoryFilterQuery, keywordQuery, languageFilterQuery, usersRows } from "../state";
import UsersTable from "../components/Users/UsersTable";
import ClipLoader from "react-spinners/ClipLoader";
import ContractsList from './ContractsList'

const Contracts = () => {
  const [page, setPage] = useState(1); // Start page from 1
  const [limit, setLimit] = useState(10);
  const [pages, setPages] = useState(0);
  const [rows, setRows] = useState(0);
  const [keyword, setKeyword] = useRecoilState(keywordQuery);
  const [languageFilter, setLanguageFilter] = useRecoilState(languageFilterQuery);
  const [contracts, setContracts] = useRecoilState(searchedDContracts);

  const [msg, setMsg] = useState("");
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const { currentUser, logout } = useContext(AuthContext)
  const [isCreating, setIsCreating] = useRecoilState(isCreatingPost)
  const [isCreatingLocal, setIsCreatingLocal] = useState(false);

  const [isViewingPostDetails, setIsViewingPostDetails] = useRecoilState(viewingPostDetails)
  const [isViewingPostDetailsLocal, setIsViewingPostDetailsLocal] = useState(false)
  const [isMounted, setIsMounted] = useState(true);
  const [studentData, setStudentData] = useState({})
  const params = useParams();

  useEffect(() => {
    getUsers();
  }, [page, keyword, languageFilter]);

  const getUsers = async () => {
    try {
      setContracts([]);
      setLoading(true);

      const response = await axios.get(`${process.env.REACT_APP_BASE_URL}/contracts/filter?searchQuery=${keyword}&languageFilter=${languageFilter}&page=${page}&limit=${limit}`);
      setContracts(response.data.listDto);
      console.log(response);
      setPage(response.data.pagination.page);
      setPages(response.data.pagination.totalPage);
      setRows(response.data.pagination.totalRows);
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
      }
      console.error(err);
    } finally {
      setLoading(false); // Set loading to false when the request is completed (success or error)
    }
  };

  const changePage = ({ selected }) => {
    console.log(selected);
    setPage(selected + 1);
    console.log(contracts);
    // Add 1 to start from page 1
    if (selected === 9) {
      setMsg(".........");
    } else {
      setMsg("");
    }
  };




  // useEffect(() => {
  //   // Scroll to the top of the page when the component mounts

  //   setTimeout(function () {
  //     window.scrollTo(0, 0);
  // },2);
  // }, []);

 
  const languageOptions = [

  ];

  return (
    <div className='container' id='student-container' style={{ marginTop: "50px" }}>
      
      <div className="container mt-4">
        <div className="row">
          <div className="col-12">
            {loading ? ( // Display the spinner conditionally based on the loading state
              <div style={{ marginBottom: '400px', marginTop: '380px', display: 'flex', justifyContent: 'center' }}>
                <ClipLoader
                  color={"#00BF63"}
                  loading={true}
                  size={40}
                  aria-label="Loading Spinner"
                  data-testid="loader"
                />
              </div>


            ) :
              (<Outlet />)}
          </div>
        </div>
      </div>
      <hr className='student-bar' />
    </div>


  )
}

export default Contracts




