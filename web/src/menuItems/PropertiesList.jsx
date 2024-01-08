"use client"
import React, { useState, useEffect } from "react";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import ReactPaginate from "react-paginate";
// import Post from "./Post";
import '../styles/PostList.css'
import { categoryFilterQuery, isLoading, keywordQuery, languageFilterQuery, searchedProperties, studentPosts } from "../state";
import { useRecoilState } from "recoil";
import { ToastContainer, toast } from 'react-toastify'
import { useNavigate, useParams } from "react-router-dom";
import ClipLoader from "react-spinners/ClipLoader";
import Backdrop from '@material-ui/core/Backdrop';
import CircularProgress from '@material-ui/core/CircularProgress';
import { GoogleMap, Marker, useJsApiLoader, useLoadScript } from "@react-google-maps/api";

import { makeStyles } from '@material-ui/core/styles';
import Complaint from "./Complaint";
import Property from "./Property";
import SearchBar from "../components/SearchBar/SearchBar";
const useStyles = makeStyles((theme) => ({
  backdrop: {
    zIndex: theme.zIndex.drawer + 1,
    color: '#fff',
  },
}));


const PropertiesList = () => {
  const { isLoaded } = useJsApiLoader({
    id: process.env.REACT_APP_GOOGLE_API_KEY,
    googleMapsApiKey: process.env.REACT_APP_GOOGLE_API_KEY
  })
  const containerStyle = {
    width: '600px',
    height: '800px'
  };

  const center = {
    lat: -3.745,
    lng: -38.523
  };
  // const { isLoaded } = useState(true)
  // const onLoad = React.useCallback(function callback(map) {
  //   // This is just an example of getting and using the map instance!!! don't just blindly copy!
  //   const bounds = new window.google.maps.LatLngBounds(center);
  //   map.fitBounds(bounds);

  //   setMap(map)
  // }, [])

  // const onUnmount = React.useCallback(function callback(map) {
  //   setMap(null)
  // }, [])
  // const [map, setMap] = React.useState(null)

  
  const classes = useStyles();
  const [complaints, setComplaints] = useState([]);
  const [page, setPage] = useState(1);
  const [limit, setLimit] = useState(6);
  const [pages, setPages] = useState(0);
  const [rows, setRows] = useState(0);
  const [keyword, setKeyword] = useRecoilState(keywordQuery);
  const [languageFilter, setLanguageFilter] = useRecoilState(languageFilterQuery);
  const [categoryFilter, setCategoryFilter] = useRecoilState(categoryFilterQuery);
  const [isLoadingHome, setIsLoadingHome] = useRecoilState(isLoading);
  const [loading, setLoading] = useState(false);
  const [msg, setMsg] = useState("");
  const navigate = useNavigate();
  const position = { lat: 53, lang: 10 }
  const [properties, setProperties] = useRecoilState(searchedProperties);


  const params = useParams();
  useEffect(() => {
    setIsLoadingHome(false)
  }, [page]);

  useEffect(() => {
    setCategoryFilter("");
    setLanguageFilter("");
    setKeyword("");
  }, [params])



  const handleApiError = (err) => {
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
  };

  const changePage = ({ selected }) => {
    setPage(selected + 1);
    if (selected === 9) {
      setMsg(".........");
    } else {
      setMsg("");
    }
  };

  return (
    <>
      <div style={{ paddingRight: "0px" }}>
        <div className="row">
          <div className="l-search">Search about properties</div>
        </div>
        <div className="items">

          <div className="container" id='row-items'>
            <div className="row" id='search-bar-up'>
              <SearchBar searchHint="Search about properties by location" />
            </div>

          </div>

        </div>
      </div>

      <div className="container" id='row-items'>

        {/* <APIProvider apiKey={process.env.REACT_APP_GOOGLE_API_KEY}>
          <div style={{height: "80vh"}}>
            <Map zoom={9} center={position}> </Map>
          </div>
        </APIProvider> */}

        {isLoaded ? (
        <GoogleMap
          mapContainerStyle={containerStyle}
          center={center}
          zoom={10}
          // onLoad={onLoad}
          // onUnmount={onUnmount}
        >
          { /* Child components, such as markers, info windows, etc. */}
          <></>
        </GoogleMap>
        ) : <>Loading map,   Opps !</>}
      </div>

      <div style={{ paddingRight: "0px" }}>

        <div className="items">

          <div className="container" id='row-items'>
            <div className="row" id='search-bar-up'>
              <SearchBar searchHint="Search about properties by Id" />
            </div>

          </div>

        </div>
      </div>
      <ToastContainer />
      {loading ? ( // Display the spinner conditionally based on the loading state
        <div style={{ marginBottom: '20px', display: 'flex', justifyContent: 'center' }}>
          <ClipLoader
            color={"#00BF63"}
            loading={true}
            size={40}
            aria-label="Loading Spinner"
            data-testid="loader"
          />
        </div>


      ) : (
        <div className="post-list" style={{ marginTop: "50px", marginLeft: "20px" }}>
          {properties.length !== 0 ? (
            properties.map((property) => <Property key={property.id} propertyData={property} />)
          ) : (
            <h1 className="posts-found">      No Properties Found</h1>
          )}
          Total Posts: {rows} Page: {page} of {pages}
        </div>
      )}
      <p className="text-danger">{msg}</p>
      <nav className="d-flex justify-content-center">
        <ReactPaginate
          breakLabel="..."
          previousLabel={"Prev"}
          nextLabel={"Next"}
          pageRangeDisplayed={3}
          pageCount={pages}
          onPageChange={changePage}
          containerClassName={"pagination"}
          pageLinkClassName={"page-num"}
          previousLinkClassName={"page-num"}
          nextLinkClassName={"page-num"}
          activeLinkClassName={"active"}
          disabledLinkClassName={"pagination-link is-disabled"}
        />
      </nav>
    </>
  );
};

export default (PropertiesList);
