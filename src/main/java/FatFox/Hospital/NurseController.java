package FatFox.Hospital;

import FatFox.Hospital.Nurse;
import FatFox.Hospital.NurseService;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
public class NurseController {
    @Autowired
    private NurseService nurseService;

    @GetMapping("/nurses/search")
    public List<Nurse> searchNurses(@RequestParam String name) {
        return nurseService.searchByName(name);
    }
    
    @GetMapping("/nurses/index")
	public List<Nurse> getAll() {
		return nurseService.getAllNurses();
	}
}