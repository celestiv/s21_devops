package com.s21.devops.sample.hotelservice.Communication;

import com.s21.devops.sample.hotelservice.Communication.Aux.RoomFilling;

public class PatchRoomsInfoReq {
    private Iterable<RoomFilling> rooms;

    public Iterable<RoomFilling> getRooms() {
        return rooms;
    }

    public void setRooms(Iterable<RoomFilling> rooms) {
        this.rooms = rooms;
    }
}
