import { LightningElement, track, wire, api } from 'lwc';
import upcomingEvents from "@salesforce/apex/AttendeeEventService.upcomingEvents";
import pastEvents from "@salesforce/apex/AttendeeEventService.pastEvents";

export default class AttendeeDetails extends LightningElement {
    @api recordId;
    @track eventCol = [
        {
            label: 'Name',
            fieldName: 'Name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Location',
            fieldName: 'Location',
            type: 'text',
            sortable: true
        },
        {
            label: 'Start Date',
            fieldName: 'Start_Date__c',
            type: 'date',
            typeAttributes: {
                weekday: 'long',
                day: 'numeric',
                month: 'short',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
              }
        },
        {
            label: 'End Date',
            fieldName: 'End_Date__c',
            type: 'date',
            typeAttributes: {
                weekday: 'long',
                day: 'numeric',
                month: 'short',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
              }
        }        
    ];

    @track error;
    @track upcomingEventsList;
    @wire(upcomingEvents, {attendeeId : '$recordId'})
    wiredUpcomingEvents({error,data}){
        var returnOptions =[];
      if(data){
        data.forEach(ele => {

            var loc;
                if(ele.Event__r.Location__c){
                    loc = ele.Event__r.Location__r.Name;
                }else{
                    loc = 'This is Virtual';
                }

            returnOptions.push({Name:ele.Event__r.Name__c,
                Start_Date__c:ele.Event__r.Start_Date__c,
                Location:loc,
                End_Date__c:ele.Event__r.End_Date__c
            }); 
            
            })
          
        this.upcomingEventsList = returnOptions;
        }
      else{ console.log(error);}
    }

    @track pastEventsList;
    @wire(pastEvents, {attendeeId : '$recordId'})
    wiredPastEvents({error,data}){
        var returnOptions =[];
      if(data){
        data.forEach(ele => {

            var loc;
                if(ele.Event__r.Location__c){
                    loc = ele.Event__r.Location__r.Name;
                }else{
                    loc = 'This is Virtual';
                }

            returnOptions.push({Name:ele.Event__r.Name__c,
                Start_Date__c:ele.Event__r.Start_Date__c,
                Location:loc,
                End_Date__c:ele.Event__r.End_Date__c
            }); 
            
            })
          
        this.pastEventsList = returnOptions;
        }
      else{ console.log(error);}
    }

}