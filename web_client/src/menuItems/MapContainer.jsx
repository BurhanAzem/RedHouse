import { Map, InfoWindow, Marker, GoogleApiWrapper } from 'google-maps-react';
import { Component } from 'react';

export class MapContainer extends Component {
    render() {
        return (
            <Map 
            google={this.props.google}
            initialCenter={{
                lat: 40.854885,
                lng: -88.081807
            }}
            zoom={14}>

                {/* <Marker onClick={this.onMarkerClick}
                name={'Current location'} />
 
        <InfoWindow onClose={this.onInfoWindowClose}>
            <div>
              <h1>{this.state.selectedPlace.name}</h1>
            </div>
        </InfoWindow> */}
            </Map>
        );
    }
}

export default GoogleApiWrapper({
    apiKey: "AIzaSyCHqSp4_YvEXCpwvOpKmp65ElyNd5W85O4"
})(MapContainer)