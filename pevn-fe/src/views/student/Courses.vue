<template>
  <v-container>
    <NavbarS :s_name="student.name" />

    <v-alert text v-model="alert.show" :type="alert.type" dismissible>{{alert.message}}</v-alert>
    <h1 class="font-weight-light">All courses</h1>
    <v-row justify="center">
      <v-card class="ma-3" max-width="344" v-for="course in coursesList" :key="course.id_c">
        <v-img
          src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
          height="200px"
          class="white--text align-end"
        >
          <v-card-title>{{course.c_name}}</v-card-title>
          <v-card-subtitle class="white--text">
            <b>Professor:</b>
            {{course.p_name}}
          </v-card-subtitle>
        </v-img>
        <v-card-text>
          {{course.c_description}}
          <div>
            <b>E-mail:</b>
            {{course.p_email}}
          </div>
        </v-card-text>
        <v-card-actions>
          <v-btn color="purple" dark absolute right @click="joinIn(course.id_c)">join</v-btn>
        </v-card-actions>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
import NavbarS from "@/components/NavbarS";

export default {
  data: () => ({
    student: {},
    coursesList: [],
    alert: { show: false }
  }),
  methods: {
    async joinIn(id_c) {
      try {
        const res = await this.axios.post(
          `/student/course/${id_c}`,
          this.student
        );
        const index = this.coursesList.findIndex(c => c.id_c == id_c);
        this.coursesList.splice(index, 1);
        this.alert = {
          show: true,
          type: "success",
          message: res.data.message
        };
      } catch (error) {
        console.log(error);
      }
    }
  },
  created: async function() {
    this.student = JSON.parse(sessionStorage.getItem("session"));
    if (this.student == null) {
      this.$router.push("/");
    } else if (this.student.role != "student") {
      this.$router.push("/profile");
    } else {
      try {
        const res = await this.axios.get(`/student/courses/${this.student.id}`);
        this.coursesList = res.data;
      } catch (error) {
        console.log(error);
      }
    }
  },
  components: {
    NavbarS
  }
};
</script>