within Q100_DistrictModel.ElectrolysisSystem.Media;
package Functions "standalone property functions"

  package H2
    function cp "specific heat capacity based on shomate equation"

      //https://webbook.nist.gov/cgi/cbook.cgi?ID=C1333740&Mask=1&Type=JANAFG&Plot=on
      input SI.Temperature T;
      output SI.SpecificHeatCapacityAtConstantPressure shc;

      // coefficient for range 298-1000K
    protected
      Real A= 33.066178;
      Real B= -11.363417;
      Real C= 11.432816;
      Real D= -2.772874;
      Real E= -0.158558;

      Real t= T/1000;

    algorithm

      shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

    end cp;

    function S "temperature dependent molar entropy of hydrogen"

      //https://webbook.nist.gov/cgi/cbook.cgi?ID=C1333740&Mask=1&Type=JANAFG&Plot=on
      input SI.Temperature T;
      output SI.MolarEntropy ent;

      // coefficient for range 298-1000K
    protected
       Real A= 33.066178;
      Real B= -11.363417;
      Real C= 11.432816;
      Real D= -2.772874;
      Real E= -0.158558;
      Real G= 172.707974;

      Real t= min(max(T,298),1000)/1000;
    algorithm
      ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
    end S;
  end H2;

  package O2
    function cp "specific heat capacity based on shomate equation"

      //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782447&Mask=1
      input SI.Temperature T;
      output SI.SpecificHeatCapacityAtConstantPressure shc;

      // coefficient for range 100-700K
    protected
      Real A= 31.32234;
      Real B= -20.23531;
      Real C= 57.86644;
      Real D= -36.50624;
      Real E= -0.007374;

      Real t= T/1000;

    algorithm

      shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

    end cp;

    function S "temperature dependent molar entropy of oxygen"

      //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782447&Mask=1
      input SI.Temperature T;
      output SI.MolarEntropy ent;

      // coefficient for range 100-700K
    protected
      Real A= 31.32234;
      Real B= -20.23531;
      Real C= 57.86644;
      Real D= -36.50624;
      Real E= -0.007374;
      Real G= 246.7945;

      Real t= min(max(T,100),700)/1000;
    algorithm
      ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
    end S;
  end O2;

  package H2O
    function cp "specific heat capacity based on shomate equation"

      //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
      input SI.Temperature T;
      output SI.SpecificHeatCapacityAtConstantPressure shc;

      // coefficient for range 298-500K
    protected
      Real A= -203.6060;
      Real B= 1523.290;
      Real C= -3196.413;
      Real D= 2474.455;
      Real E= 3.855326;

      Real t= T/1000;

    algorithm

      shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

    end cp;

    function deltaH "temperature dependent molar enthalpy of water"

      //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
      input SI.Temperature T;
      output SI.MolarEnthalpy ent;

      // coefficient for range 298-500K
    protected
      Real A= -203.6060;
      Real B= 1523.290;
      Real C= -3196.413;
      Real D= 2474.455;
      Real E= 3.855326;
      Real F= -256.5478;
      Real G= -488.7163;
      Real H= -285.8304;

      Real t= T/1000;
      Real H0 = -285.830;
    algorithm

      ent := (H0 + A*t + B*t^2/2 + C*t^3/3 + D*t^4/4 - E/t + F - H)*1000;

    end deltaH;

    function S "temperature dependent molar entropy of water"

      //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
      input SI.Temperature T;
      output SI.MolarEntropy ent;

      // coefficient for range 298-500K
    protected
      Real A= -203.6060;
      Real B= 1523.290;
      Real C= -3196.413;
      Real D= 2474.455;
      Real E= 3.855326;
      Real G= -488.7163;

      Real t= min(max(T,298),500)/1000;
    algorithm
      ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
    end S;
  end H2O;
end Functions;
