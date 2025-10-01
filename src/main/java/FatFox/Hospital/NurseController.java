package FatFox.Hospital;

import FatFox.Hospital.Nurse;
import FatFox.Hospital.NurseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;

@RestController
public class NurseController implements WebMvcConfigurer {
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

	@Configuration
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/home").setViewName("home");
		registry.addViewController("/").setViewName("home");
		registry.addViewController("/hello").setViewName("hello");
		registry.addViewController("/login").setViewName("login");
	}

}